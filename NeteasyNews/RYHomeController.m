//
//  RYHomeController.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYHomeController.h"
#import "RYChannelModel.h"
#import "RYChannelLabel.h"
#import "RYHomeCell.h"

@interface RYHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *sc_channelList;
@property (weak, nonatomic) IBOutlet UICollectionView *cv_collectionView;
@property (nonatomic,strong) NSArray *channelList;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cv_flowLayout;

//@property (nonatomic,strong) RYChannelLabel *currentLabel;
//@property (nonatomic,strong) RYChannelLabel *nextLabel;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation RYHomeController
#warning Ryukie:11_不需要异步加载的属性可以懒加载
- (NSArray *)channelList {
    if (!_channelList) {
        //类方法懒加载
        _channelList = [RYChannelModel channelList];
    }
    return _channelList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadChannelList];
    #pragma mark - Ryukie:设置一开始的label为放大的
   RYChannelLabel *label = self.sc_channelList.subviews[0];
    label.scale = 1.0;
}
#pragma mark - Ryukie:显示频道
- (void)loadChannelList {
#warning Ryukie:12_当有导航栏的情况下,scrollview会默认有一个上边距,编剧的大小就是导航栏的高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat margin = 5;
    __block CGFloat ChannelX = margin;//第一个label的x值 以后累加
    CGFloat height = self.sc_channelList.frame.size.height;
    
    
    //遍历数组创建Label
    [self.channelList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RYChannelModel *cModel = self.channelList[idx];
        RYChannelLabel *label = [[RYChannelLabel alloc] init];
        label.text = cModel.tname;
#warning Ryukie:13_由于后面要将当前的label放大,所以label的frame需要适应两种大下坡,可以通过向将器撑大然后再更改字体为小字体
        label.font = [UIFont systemFontOfSize:16];
        [label sizeToFit];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(ChannelX, 0, label.frame.size.width, height);
        ChannelX += label.frame.size.width + margin;
        [self.sc_channelList addSubview:label];
    }];
    [self.sc_channelList setContentSize:CGSizeMake(ChannelX, height)];
}
#pragma mark - Ryukie:collectionViewDataSourceDelegete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = @"homeCell";
    RYHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:key forIndexPath:indexPath];
    cell.tag = indexPath.item;
    RYChannelModel *labelModel = self.channelList[indexPath.item];
//    NSLog(@"%s%@",__FUNCTION__,labelModel.tid);
    cell.channelDataURLStr = labelModel.tid;
    
    return cell;
}
- (void)setUpFlowLayout {
    self.cv_flowLayout.itemSize = self.cv_collectionView.frame.size;
    self.cv_flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cv_flowLayout.minimumInteritemSpacing = 0;
    self.cv_flowLayout.minimumLineSpacing = 0;
    
    self.cv_collectionView.bounces = NO;
    self.cv_collectionView.showsHorizontalScrollIndicator = YES;
    self.cv_collectionView.pagingEnabled = YES;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setUpFlowLayout];
}
#pragma mark - Ryukie:滚动新闻页面的时候同时让频道标签放大并变色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取当前序号
//    NSInteger indexCurrent = self.cv_collectionView.contentOffset.x/self.cv_collectionView.frame.size.width;
    //获取对应的label
    RYChannelLabel *currentLabel = self.sc_channelList.subviews[self.currentIndex];
    RYChannelLabel *nextLabel = nil;
    //获得偏移量
    CGFloat scale = ABS(self.cv_collectionView.contentOffset.x*1.0/self.cv_collectionView.frame.size.width - self.currentIndex);
    CGFloat scaleOther = 1-scale;
#warning Ryukie:16_ visibleCells & indexPathsForVisibleItems
    //获取当前可见的cell
    NSArray *visableCells = [self.cv_collectionView visibleCells];
    for (RYHomeCell *cell in visableCells) {
        //需要判断cell是否为当前cell  通过tag  获取下一个的label
        if (cell.tag != self.currentIndex) {
            nextLabel = self.sc_channelList.subviews[cell.tag];
            break;
        }
    }
    
    //获取可见cell 的index
//    for (NSIndexPath *indexPath in self.cv_collectionView.indexPathsForVisibleItems) {
//        if(indexPath.item != self.currentIndex){
//            //就是下一个频道的索引
//            nextLabel = self.sc_channelList.subviews[indexPath.item];
//            break;
//        }
//    }
    
    NSLog(@"%f  %f  %ld",scale,scaleOther,(long)self.currentIndex);
    currentLabel.scale = scaleOther;
    nextLabel.scale = scale;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //获取当前序号
    self.currentIndex = self.cv_collectionView.contentOffset.x/self.cv_collectionView.frame.size.width;
    RYChannelLabel *label = self.sc_channelList.subviews[self.currentIndex];
#pragma mark - Ryukie:当滚动完毕让部分label滚动到品目中间
    //获取当前对应 label 初始位置的重点
    CGFloat orginCenterX = label.center.x;
    if (orginCenterX > self.sc_channelList.bounds.size.width/2
        &&
        orginCenterX < (scrollView.contentSize.width-[UIScreen mainScreen].bounds.size.width/2)) {
        //如果在此范围内就滚动到屏幕中间
        self.sc_channelList.contentOffset = CGPointMake(orginCenterX - [UIScreen mainScreen].bounds.size.width/2, 0);
    }
}
#warning Ryukie:17_  骗人!!!!根本不行  !!!!!!_解决放大缩小快速滚动时不正确的情况 在动画完成的时候将label还原
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.sc_channelList.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RYChannelLabel *label = obj;
        if (idx != self.currentIndex) {
            label.scale = 0;
        }else {
            label.scale = 1;
        }
    }];
}
@end

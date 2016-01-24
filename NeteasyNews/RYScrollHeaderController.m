//
//  RYScrollHeaderController.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYScrollHeaderController.h"
#import "RYHeaderModel.h"
#import "RYHeadCell.h"

@interface RYScrollHeaderController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *fl_collectionViewFlowLyout;
@property (nonatomic,strong) NSArray *headersList;

@end

@implementation RYScrollHeaderController

- (void)setHeadersList:(NSArray *)headersList {
    _headersList = headersList;
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHeadData];
#warning Ryukie:06_ 加载进去的图片轮播器的布局有误 需要在 viewDidLayoutSubviews 中布局
//    [self setupFlowLyout];
}
- (void)getHeadData {
    [RYHeaderModel getHeaderDataAndSerilizationWithSucessBlock:^(NSArray *array) {
        self.headersList = array;
//        NSLog(@"%@",array);
    } andErrorBlock:^{
        NSLog(@"error");
    }];
}
#pragma mark - Ryukie:dataSourceDelegete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.headersList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuserId = @"headCell";
    RYHeaderModel *hModel = self.headersList[indexPath.item];
    RYHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserId forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    cell.headModel = hModel;
    return cell;
}
- (void)viewDidLayoutSubviews {
    [self setupFlowLyout];
}
#pragma mark - Ryukie:setupFlowLayout
- (void)setupFlowLyout {
    self.fl_collectionViewFlowLyout.itemSize = self.collectionView.frame.size;
    self.fl_collectionViewFlowLyout.minimumInteritemSpacing = 0;
    self.fl_collectionViewFlowLyout.minimumLineSpacing = 0;
    self.collectionView.bounces = NO;//取消弹簧效果
    self.collectionView.pagingEnabled = YES;//开启分页效果
    //设置滚动方向
    self.fl_collectionViewFlowLyout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置是否显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = YES;
}
#pragma mark - Ryukie:通过3组轮播器来实现头尾跳转
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
#pragma mark - Ryukie滚动停止的时候跳转到中间一组的对应的item 这里使用的是scrollView 的一个代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //获取item的序号
    NSInteger index = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    //通过取模获取对应的中间的
    NSInteger indexMid = index % self.headersList.count;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:indexMid inSection:1];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
#warning Ryukie:04_需要设置在一开始的时候就在中间一组的第一个应该写在刚加载好数据的时候
}


@end

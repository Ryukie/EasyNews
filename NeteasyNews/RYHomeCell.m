//
//  RYHomeCell.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYHomeCell.h"
#import "RYTNewsController.h"
//#import "RYNetWorkManager.h"
#import "RYChannelModel.h"

@interface RYHomeCell ()
@property (nonatomic,strong) RYTNewsController *vc;
@end

@implementation RYHomeCell

- (void)awakeFromNib {
#warning Ryukie:14_这里获得的VC在方法执行借宿的时候会被释放掉,需要一个强引用
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    RYTNewsController *vc = [sb instantiateInitialViewController];
//    [self addSubview:vc.view];
    self.vc = [sb instantiateInitialViewController];
    //将目标控制器的View加进cell
    [self addSubview:self.vc.view];
}

#warning Ryukie:15_加载出来的旁边布局不对启动 -> homecontroller->homecell->CZNewsController.view
- (void)layoutSubviews {
    [super layoutSubviews];
    self.vc.view.frame = self.contentView.frame;
}
- (void)setChannelDataURLStr:(NSString *)channelDataURLStr {
    _channelDataURLStr = channelDataURLStr;
    self.vc.channelDataURLStr = channelDataURLStr;
}
@end

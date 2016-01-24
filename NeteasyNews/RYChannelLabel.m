//
//  RYChannelLabel.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//



#import "RYChannelLabel.h"

#define qLABELFONTMAX 16
#define qLABELFONTMIN 14

@implementation RYChannelLabel

+ (instancetype)channelWithTName:(NSString *)tName {
    //生成label
    RYChannelLabel *label = [[RYChannelLabel alloc] init];
    label.text = tName;
    //设置大字体,确定label的空间大小
    label.font = [UIFont systemFontOfSize:qLABELFONTMAX];
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:qLABELFONTMIN];
    return label;
}
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.transform = CGAffineTransformMakeScale(1+0.2*scale, 1+0.2*scale);
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}
@end

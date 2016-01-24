//
//  RYChannelLabel.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYChannelLabel : UILabel

@property (nonatomic,assign) CGFloat scale;

+ (instancetype)channelWithTName:(NSString *)tName;

@end

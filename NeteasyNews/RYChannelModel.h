//
//  RYChannelModel.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYChannelModel : NSObject
@property(nonatomic,copy) NSString *tname;
@property(nonatomic,copy) NSString *tid;

//KVC
+ (instancetype)channelWithDict:(NSDictionary *)dict;
#warning Ryukie:10_读取本地数据无须异步加载   如果文件过大的话还是异步加载把
+ (NSArray *)channelList;
@end

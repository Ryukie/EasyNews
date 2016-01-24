//
//  RYHeaderModel.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYHeaderModel : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *imgsrc;

+ (instancetype)headerModelWithDict:(NSDictionary *)dict ;

/**
 *  网络下载数据并反序列化
 */
#warning Ryukie:01_网络异步获取数据,方法不要提供返回值,而通过block回调来传递
+ (void)getHeaderDataAndSerilizationWithSucessBlock:(void(^)(NSArray *))sucessBlock andErrorBlock:(void(^)())errorBlock ;

@end

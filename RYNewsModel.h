//
//  RYNewsModel.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYNewsModel : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *digest;
@property(nonatomic,copy) NSString *imgsrc;
@property(nonatomic,copy) NSNumber *replyCount;
//大图
@property(nonatomic,assign) BOOL imgType;
//3个图
@property(nonatomic,copy) NSArray *imgextra;

//KVC
+ (instancetype)newsModelWithDict:(NSDictionary *)dict;
//异步获取网络数据
//+ (void)getNewsDataWithSucess:(void(^)(NSArray *array))sucessBlock andError:(void(^)())errorBlock;
+ (void)getNewsDataWithDataURLStr:(NSString *)dataURLStr sucess:(void(^)(NSArray *array))sucessBlock andError:(void(^)())errorBlock;

@end

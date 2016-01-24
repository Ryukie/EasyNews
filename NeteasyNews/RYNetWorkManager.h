//
//  RYNetWorkManager.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface RYNetWorkManager : AFHTTPSessionManager

//@property (nonatomic,strong) <#dataType#> <#name#>;
+ (instancetype)sharedManager;

@end

//
//  RYNetWorkManager.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYNetWorkManager.h"

@implementation RYNetWorkManager
+ (instancetype)sharedManager {
    static RYNetWorkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         1.基地址 http://c.m.163.com/nc/  ad/headline/0-4.html
         2.session配置
         */
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURL *basicUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[RYNetWorkManager alloc] initWithBaseURL:basicUrl sessionConfiguration:config];
        //设置请求超时时间
        config.timeoutIntervalForRequest = 10;//默认 60
    });
    return instance;
}
@end

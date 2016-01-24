//
//  AppDelegate.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "AppDelegate.h"
#import "RYNetWorkManager.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()
//11111
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //AFN能接受的内容数据类型
    [RYNetWorkManager sharedManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //当界面上有网络数据处理的时候转菊花
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
#warning Ryukie:06_为访问网络数据产生的文件 (数据库文件) 做缓存   图片缓存SD已经管理了
    /*
     1. 内存缓存容量限制 kb
     2. 本地混存容量限制 kb
     3. 指定缓存的相对路径
     */
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:1024*1024*5 diskPath:@"163cache"];
    //保存缓存设置到系统
    [NSURLCache setSharedURLCache:cache];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

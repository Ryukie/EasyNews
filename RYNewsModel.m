//
//  RYNewsModel.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYNewsModel.h"
#import "RYNetWorkManager.h"

@implementation RYNewsModel
+ (instancetype)newsModelWithDict:(NSDictionary *)dict {
    RYNewsModel *nModel = [RYNewsModel new];
    [nModel setValuesForKeysWithDictionary:dict];
    return nModel;
}

+ (void)getNewsDataWithDataURLStr:(NSString *)dataURLStr sucess:(void(^)(NSArray *array))sucessBlock andError:(void(^)())errorBlock {
//http://c.m.163.com/nc/ article/list/T1348648517839/0-20.html
    RYNetWorkManager *manager = [RYNetWorkManager sharedManager];
//    [[manager GET:@"article/list/T1348648517839/0-20.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    NSString *str = [NSString stringWithFormat:@"article/list/%@/0-20.html",dataURLStr];
//    NSLog(@"%s%@",__FUNCTION__,dataURLStr);
    
    [[manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *mArr = [NSMutableArray array];
        NSString *key = [responseObject keyEnumerator].nextObject;
        NSArray *tempArr = responseObject[key];
        //遍历数组
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RYNewsModel *nModel = [RYNewsModel newsModelWithDict:obj];
            [mArr addObject:nModel];
        }];
        
        if (sucessBlock) {
            sucessBlock(mArr.copy);
//            NSLog(@"%@",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock();
            NSLog(@"%@",error);
        }
    }] resume];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end

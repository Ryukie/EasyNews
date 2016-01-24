//
//  RYHeaderModel.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYHeaderModel.h"
//#import <AFNetworking.h>
#import "RYNetWorkManager.h"

@implementation RYHeaderModel

+(instancetype)headerModelWithDict:(NSDictionary *)dict {
    RYHeaderModel *hModel = [RYHeaderModel new];
    [hModel setValuesForKeysWithDictionary:dict];
    return hModel;
}
+ (void)getHeaderDataAndSerilizationWithSucessBlock:(void (^)(NSArray *))sucessBlock andErrorBlock:(void (^)())errorBlock {
    //头条的 url http://c.m.163.com/nc/ ad/headline/0-4.html
#warning Ryukie:02_设置了根路径之后只用写子路径就好了
    [[[RYNetWorkManager sharedManager] GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //反序列化json数据
        //默认反序列化JSON 无须指定反序列化器
        //通过在线格式化工具看出其中是一个字典  其中是一个数组
        NSMutableArray *mArr = [NSMutableArray array];
#warning Ryukie:03_获取字典第一个键  key 迭代器
        NSString *firstKey = [responseObject keyEnumerator].nextObject;//再点语法使用 nextObject 会获得再下一个 key
        NSArray *tempArr = responseObject[firstKey];
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RYHeaderModel *hModel = [RYHeaderModel headerModelWithDict:obj];
            [mArr addObject:hModel];
        }];
        //回调
        if (sucessBlock) {
            sucessBlock(mArr.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock();
        }
    }] resume];
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ {title = %@ , imgsrc = %@}",[super description],self.title,self.imgsrc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end

//
//  RYChannelModel.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/21.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYChannelModel.h"

@implementation RYChannelModel

+ (instancetype)channelWithDict:(NSDictionary *)dict{
    RYChannelModel *cModel = [RYChannelModel new];
    [cModel setValuesForKeysWithDictionary:dict];
    return cModel;
}
+ (NSArray *)channelList{
    NSMutableArray *mArr = [NSMutableArray array];
    //冲本地读取数据
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    //获取文件的二进制数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //json反序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //获取频道数组
    NSArray *arr = dict[@"tList"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RYChannelModel *cModel = [RYChannelModel channelWithDict:obj];
        [mArr addObject:cModel];
    }];
    
#warning Ryukie:18_排序tid ASCII
    [mArr sortUsingComparator:^NSComparisonResult(RYChannelModel * _Nonnull obj1, RYChannelModel * _Nonnull obj2) {
        //得到字符信息ascii码,用ascii进行比较
        return [obj1.tid compare:obj2.tid];
    }];
    return mArr.copy;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ {tname =%@ tid = %@}",[super description],self.tname,self.tid];
}

@end

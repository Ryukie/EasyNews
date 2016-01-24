//
//  RYTNewsController.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYTNewsController.h"
#import "RYNewsModel.h"
#import "RYNewCell.h"

@interface RYTNewsController ()

@property (nonatomic,strong) NSArray *newsList;


@end

@implementation RYTNewsController

#warning Ryukie:19_要在没吃设置的时候调用
- (void)setChannelDataURLStr:(NSString *)channelDataURLStr {
    _channelDataURLStr = channelDataURLStr;
    [RYNewsModel getNewsDataWithDataURLStr:self.channelDataURLStr sucess:^(NSArray *array) {
        self.newsList = array;
    } andError:^{
        NSLog(@"error");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [RYNewsModel getNewsDataWithSucess:^(NSArray *array) {
//        self.newsList = array;
////        NSLog(@"%@",self.newsList);
//    } andError:^{
//        NSLog(@"error");
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RYNewsModel *nModel = self.newsList[indexPath.row];
//    NSString *reuseId = @"newsCell";
//    if (nModel.imgType) {
//        reuseId = @"newsCellBig";
//    }
//    if (nModel.imgextra) {
//        reuseId = @"newsCellThreePic";
//    }
    RYNewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RYNewCell setReuseIDWithModel:nModel] forIndexPath:indexPath];
    cell.nModel = nModel;
    return cell;
#warning Ryukie:05_NSLocalizedDescription=Request failed: unacceptable content-type: text/html CT不是标准的json AFN 无法解析,需要在程序开始的时候为AFN添加一些设置
}
- (void)setNewsList:(NSArray *)newsList {
    _newsList = newsList;
    [self.tableView reloadData];
}
#warning Ryukie:08_不同的cell 匹配不同高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RYNewsModel *nModel = self.newsList[indexPath.row];
//    if (nModel.imgextra) {
//        return 150.0;
//    }
//    if (nModel.imgType) {
//        return 200.0;
//    }
//    return 100;
    return [RYNewCell setHeightWithModel:nModel];
}

@end

//
//  RYNewCell.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYNewCell.h"
#import "RYNewsModel.h"
#import <UIImageView+WebCache.h>

@interface RYNewCell ()

@end

@implementation RYNewCell

- (void)setNModel:(RYNewsModel *)nModel {
    _nModel = nModel;
    self.lb_title.text = nModel.title;
    self.lb_summary.text = nModel.digest;
    self.lb_follow.text = [NSString stringWithFormat:@"%@跟帖",nModel.replyCount];
    [self.iv_image sd_setImageWithURL:[NSURL URLWithString:nModel.imgsrc]];
    
    //为额外的图赋值
    if (nModel.imgextra) {
        //遍历获得第二第三个图片的字典
        [nModel.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imV = self.ivs_images[idx];
            [imV sd_setImageWithURL:[NSURL URLWithString:obj[@"imgsrc"]]];
        }];
    }
    
}
#warning Ryukie:09_重构部分代码
+ (NSString *)setReuseIDWithModel:(RYNewsModel *)nModel {
    if (nModel.imgType) {
        return @"newsCellBig";
    }
    if (nModel.imgextra) {
        return @"newsCellThreePic";
    }
    return @"newsCell";
}
+ (CGFloat)setHeightWithModel:(RYNewsModel *)nModel {
    if (nModel.imgextra) {
        return 150.0;
    }
    if (nModel.imgType) {
        return 200.0;
    }
    return 100;
}

@end

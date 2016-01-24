//
//  RYHeadCell.m
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import "RYHeadCell.h"
#import <UIImageView+WebCache.h>

@interface RYHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iv_image;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UIPageControl *pc_pagingC;
@end

@implementation RYHeadCell

- (void)setHeadModel:(RYHeaderModel *)headModel {
    _headModel = headModel;
    self.lb_title.text = headModel.title;
    self.pc_pagingC.currentPage = self.tag;
    [self.iv_image sd_setImageWithURL:[NSURL URLWithString:headModel.imgsrc]];
}

@end

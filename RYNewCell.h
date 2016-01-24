//
//  RYNewCell.h
//  NeteasyNews
//
//  Created by 王荣庆 on 16/1/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RYNewsModel;


@interface RYNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_image;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_summary;
@property (weak, nonatomic) IBOutlet UILabel *lb_follow;

#warning Ryukie:07_控件集合
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ivs_images;


@property (nonatomic,strong) RYNewsModel *nModel;

+ (NSString *)setReuseIDWithModel:(RYNewsModel *)nModel;
+ (CGFloat)setHeightWithModel:(RYNewsModel *)nModel;
@end

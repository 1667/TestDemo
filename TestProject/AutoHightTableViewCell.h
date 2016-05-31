//
//  AutoHightTableViewCell.h
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@protocol AutoHeightCellDelegate <NSObject>

-(void)upadteViewH;

@end

@interface AutoHightTableViewCell : UITableViewCell

-(void)setViewWithData:(GlobalModel *)model;

@property (nonatomic,strong) id<AutoHeightCellDelegate> delegate;
@property (nonatomic,strong) UIImageView *view1;
@property (nonatomic,strong) UIImageView *view2;
@property (nonatomic,strong) UIImageView *view3;

@end

//
//  SwipTableViewCell.m
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "SwipTableViewCell.h"
#import "Utils.h"

@interface SwipTableViewCell() <UIScrollViewDelegate>

@end

@implementation SwipTableViewCell
{
    
}

- (void)awakeFromNib {
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.right.equalTo(self.contentView.right).offset(-10);
        make.top.equalTo(self.contentView.top).offset(10);
        make.bottom.lessThanOrEqualTo(self.contentView.bottom).offset(-10);
    }];
//
    
}

-(UILabel *)label
{
    if (_label == nil) {
        _label = [UILabel new];
        [self.contentView addSubview:_label];
        _label.preferredMaxLayoutWidth = SCREEN_W-20;
        _label.numberOfLines = 3;
    }
    return _label;
}


@end

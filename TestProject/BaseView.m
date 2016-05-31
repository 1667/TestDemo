//
//  BaseView.m
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = [[NSMutableArray alloc] initWithObjects:
                       [UIImage imageNamed:@"tu8601_5.jpg"],
                       [UIImage imageNamed:@"tu8601_7.jpg"],
                       [UIImage imageNamed:@"tu8601_10.jpg"], nil];
        _imageIndex = 0;
        [self initView];
    }
    return self;
}


-(void)initView
{
    
}

-(UIImage *)getCurrentImage
{
    _imageIndex++;
    return (_imageArray[_imageIndex % [_imageArray count]]);
}

@end

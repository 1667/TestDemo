//
//  ImageCollectionViewCell.m
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "Utils.h"

@implementation ImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    self.imageView = [UIImageView new];
    [self addSubview:_imageView];
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
}

-(void)setBVideo:(BOOL)bVideo
{
    if (bVideo) {
        UIImageView *imagePlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playV"]];
        imagePlay.tag = 166;
        [_imageView addSubview:imagePlay];
        [imagePlay makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.center.equalTo(_imageView);
        }];
    }
}

@end

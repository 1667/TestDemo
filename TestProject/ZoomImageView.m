//
//  ZoomImageView.m
//  TTT
//
//  Created by innke on 15/8/27.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import "ZoomImageView.h"
#import "UIImage+LocalSize.h"

@interface ZoomImageView()<UIScrollViewDelegate>

@end

@implementation ZoomImageView
{
    
}

-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)iv
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iv = [[UIImageView alloc] initWithImage:iv];
        _iv.userInteractionEnabled = YES;
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame ImageView:(UIImageView *)iv
{
    self = [super initWithFrame:frame];
    if (self) {
        _iv = iv;
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    if (!self.iv) {
        _iv = [[UIImageView alloc] init];
        _iv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ivTap:)];
        [_iv addGestureRecognizer:tap];
        
    }
    _iv.image = nil;
    _iv.image = image;
    [self setimageViewFrame];

    
}

-(UIImage *)getImage
{
    return _iv.image;
}

-(CGRect)getImageViewFrameWithSize:(CGSize)size
{
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - size.height)/2;
    if (y < 0) {
        y = 0;
    }
    return CGRectMake(0, y, size.width, size.height);
    
    
}

-(void)layoutSubviews
{
    UIScrollView *_sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _sv.delegate = self;
    _sv.minimumZoomScale = 1.0;
    _sv.maximumZoomScale = 3.0;
    [self addSubview:_sv];
    [self setimageViewFrame];
    
    [_sv addSubview:_iv];
    
}

-(void)setimageViewFrame
{
    CGSize size = [_iv.image localImageSizeWithWidth:[UIScreen mainScreen].bounds.size.width];
    _iv.frame = [self getImageViewFrameWithSize:size];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _iv;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _iv.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            scrollView.contentSize.height * 0.5 + offsetY);
}

-(void)ivTap:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(ZoomImageTaped:)]) {
        [_delegate ZoomImageTaped:self];
    }
}

@end

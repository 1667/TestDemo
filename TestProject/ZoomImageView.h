//
//  ZoomImageView.h
//  TTT
//
//  Created by innke on 15/8/27.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoomImageView;

@protocol ZoomImageTapDelegate <NSObject>

-(void)ZoomImageTaped:(ZoomImageView *)Zoomview;

@end

@interface ZoomImageView : UIView


@property (nonatomic,strong)UIImageView *iv;
@property (nonatomic,strong)id<ZoomImageTapDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)iv;
-(instancetype)initWithFrame:(CGRect)frame ImageView:(UIImageView *)iv;
-(void)setImage:(UIImage *)image;

-(UIImage *)getImage;



@end

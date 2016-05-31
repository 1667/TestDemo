//
//  ImageViewViewController.h
//  TTT
//
//  Created by innke on 15/8/27.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewViewController : UIViewController
{
    
}

@property (nonatomic,assign)NSInteger           startIndex;
@property (nonatomic,strong)NSMutableArray      *bigArray;


-(void)setImageArray:(NSMutableArray *)array;
-(void)setImageArrayWithImages:(NSMutableArray *)array;
-(void)setImageArrayWithImages:(NSMutableArray *)array withAnimateFrame:(CGRect)frame;
-(void)setImageArray:(NSMutableArray *)array withAnimateFrame:(CGRect)frame;
@end

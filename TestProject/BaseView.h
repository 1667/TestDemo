//
//  BaseView.h
//  TTTT
//
//  Created by 无线盈 on 15/10/12.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface BaseView : UIView

@property (nonatomic,strong)NSMutableArray  *imageArray;
@property (nonatomic,assign)NSInteger       imageIndex;


-(void)initView;

-(UIImage*)getCurrentImage;

@end

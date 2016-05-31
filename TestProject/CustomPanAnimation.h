//
//  CustomPanAnimation.h
//  TestProject
//
//  Created by wxy on 15/11/23.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPopAnimation.h"

@interface CustomPanAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic,assign) BOOL       isActing;
@property (nonatomic,strong) CustomPopAnimation     *customPop;

-(void)writeToViewContorller:(UIViewController *)toVc;

@end

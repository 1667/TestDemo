//
//  CustomPushAnimation.m
//  TestProject
//
//  Created by wxy on 15/11/23.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "CustomPushAnimation.h"
#import "NewImageViewViewController.h"
#import "UIImage+LocalSize.h"
#import "Utils.h"

#define TransitonD      0.3

@interface CustomPushAnimation()

@end

@implementation CustomPushAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return TransitonD;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NewImageViewViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIImageView *fromImageView = [UIImageView new];
    fromImageView.frame = toVc.fromeframe;
    fromImageView.image = toVc.selectImage;

    toVc.view.alpha = 0;
    fromVc.view.alpha = 1.0;
    CGRect toFrame = [Utils getImageViewFrameWithSize:[fromImageView.image localImageSizeWithWidth:SCREEN_W]];
   
    [container addSubview:toVc.view];
    [container addSubview:fromVc.view];
    [container addSubview:fromImageView];
    
    [UIView animateWithDuration:TransitonD delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromImageView.frame = toFrame;
        toVc.view.alpha = 1;
        fromVc.view.alpha = 0;
    } completion:^(BOOL finished) {
        
        fromVc.view.alpha = 1;
        [toVc.midIamgeView setHidden:NO];
        [fromImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
        
        
    }];
    
    
}

@end

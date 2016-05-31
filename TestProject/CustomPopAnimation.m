//
//  CustomPopAnimation.m
//  TestProject
//
//  Created by wxy on 15/11/23.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "CustomPopAnimation.h"
#import "NewImageViewViewController.h"
#import "Utils.h"

#define PopTransitonD   1

@implementation CustomPopAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return PopTransitonD;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NewImageViewViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *fromImageView = [fromVc.midIamgeView snapshotViewAfterScreenUpdates:NO];
    fromVc.midIamgeView.hidden = YES;
    toVc.view.alpha = 0;
    fromVc.view.alpha = 1;
    fromImageView.alpha = 1;
    [container addSubview:toVc.view];
    [container addSubview:fromVc.view];
    [container addSubview:fromImageView];
    CGRect toFrame = CGRectMake(-SCREEN_W/2, -SCREEN_H/2, SCREEN_W*2, SCREEN_H*2);
    [UIView animateWithDuration:PopTransitonD delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromImageView.frame = toFrame;
        fromImageView.alpha = 0;
        toVc.view.alpha = 1;
        fromVc.view.alpha = 0;
    } completion:^(BOOL finished) {
    
        [fromImageView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    
        
    }];

}

@end

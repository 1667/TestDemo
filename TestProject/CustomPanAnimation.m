//
//  CustomPanAnimation.m
//  TestProject
//
//  Created by wxy on 15/11/23.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "CustomPanAnimation.h"

@interface CustomPanAnimation()

@property (assign,nonatomic) BOOL canReceive;


@end


@implementation CustomPanAnimation
{
UIViewController *_remVc;
}
-(void)writeToViewContorller:(UIViewController *)toVc
{
    
    if(_remVc)
    {
        [_remVc.view removeGestureRecognizer:[_remVc.view.gestureRecognizers lastObject]];
        _remVc = nil;
    }
    _remVc = toVc;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecongnizer:)];
    [_remVc.view addGestureRecognizer:pan];
}


-(void)panRecongnizer:(UIPanGestureRecognizer *)pan
{
    CGPoint panPoint = [pan translationInView:pan.view.superview];
    CGPoint localPoint = [pan locationInView:pan.view.superview];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.isActing = YES;
        
        if (localPoint.y >= _remVc.view.bounds.size.height*0.2 && localPoint.y <= _remVc.view.bounds.size.height *0.8) {
            [_remVc.navigationController popViewControllerAnimated:YES];
        }
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        if (panPoint.y >= _remVc.view.bounds.size.height/5) {
            self.canReceive = YES;
        }
        else
        {
            self.canReceive = NO;
        }
        [self updateInteractiveTransition:panPoint.y/_remVc.view.bounds.size.height];
    }
    else if(pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded)
    {
        self.isActing = NO;
        
       
            
            [self finishInteractiveTransition];
        
    }
    
}


@end

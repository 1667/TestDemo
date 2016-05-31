//
//  BottomInputViewController.m
//  TestProject
//
//  Created by wxy on 15/11/27.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "BottomInputViewController.h"
#import "BottomInputView.h"

@interface BottomInputViewController ()

@property (nonatomic,strong)BottomInputView *bottomView;

@end

@implementation BottomInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE_COLOR];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initProperty

-(BottomInputView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BottomInputView alloc] init];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

#pragma mark Fun

-(void)initView
{
    self.bottomView.frame = CGRectMake(0, SCREEN_H-50, SCREEN_W, 50);
}

-(void)keyboardEditDidShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    // 根据老的 frame 设定新的 frame
    CGRect newTextViewFrame = self.bottomView.frame; // by michael
    newTextViewFrame.origin.y = keyboardRect.origin.y - self.bottomView.frame.size.height;
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    // 开始及执行动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    self.bottomView.frame = newTextViewFrame;
    [UIView commitAnimations];
}

-(void)keyboardEditDidHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject =[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    CGRect newTextViewFrame = self.bottomView.frame;
    newTextViewFrame.origin.y = SCREEN_H - self.bottomView.frame.size.height;
    self.bottomView.frame = newTextViewFrame;
    [UIView commitAnimations];
}

@end

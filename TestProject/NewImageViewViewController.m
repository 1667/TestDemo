//
//  NewImageViewViewController.m
//  TestProject
//
//  Created by wxy on 15/11/19.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "NewImageViewViewController.h"

#import "UIImage+Image.h"
#import "Utils.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+LocalSize.h"

#define ViewSpace   00

@interface NewImageViewViewController ()<UIScrollViewDelegate>

@end

@implementation NewImageViewViewController
{
    NSMutableArray *_imageArray;
    BOOL            bShowBar;
    UIPageControl   *_pageControl;
    UILabel         *titleLabel;
    CGRect          fristFrame;
    CGRect          secondrFrame;
    UIScrollView    *_sv;
    ZoomImageView             *leftIamgeView;
    
    ZoomImageView             *rightIamgeView;
    NSInteger                   _index;
    NSInteger       _currentIndex;
    UIImageView     *_topImageV;
    UIView          *_blackView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _currentIndex = _startIndex;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.text = [NSString stringWithFormat:@"1/%ld",[_bigArray count]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sv = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _sv.showsVerticalScrollIndicator = NO;
    _sv.showsHorizontalScrollIndicator = NO;
    [_sv setBounces:NO];
    _sv.delegate = self;
    _sv.pagingEnabled = YES;
    [self.view addSubview:_sv];
    
    float x = 0;
    ZoomImageView *tmpIV = nil;
    
    for (int i = 0; i < 3; i++) {
        tmpIV = [[ZoomImageView alloc] initWithFrame:CGRectMake(x+ViewSpace, 0, self.view.frame.size.width, self.view.frame.size.height) Image:[self getBigImageFromIndex:_startIndex+i-1]];
        tmpIV.userInteractionEnabled = YES;
        tmpIV.tag = i+133;
        
        [_sv addSubview:tmpIV];
        x += self.view.frame.size.width+ViewSpace;
    }
    [_sv setUserInteractionEnabled:YES];
    leftIamgeView = [_sv viewWithTag:133];
    _midIamgeView =[_sv viewWithTag:134];
    _midIamgeView.hidden = YES;
    rightIamgeView = [_sv viewWithTag:135];
    _blackView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W*0.1, SCREEN_H)];
    [_blackView setBackgroundColor:[UIColor blackColor]];
    [_sv addSubview:_blackView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_sv addGestureRecognizer:tap];
    [_sv setContentSize:CGSizeMake(x, 0)];
    [_sv setContentOffset:[self contentOffsetForIndex:1] animated:NO];
    [titleLabel setText:[NSString stringWithFormat:@"%ld/%ld",_startIndex+1,[_bigArray count]]];
    [self initView];

}

-(UIImage *)getBigImageFromIndex:(NSInteger)index
{
    NSInteger tmpI = index;
    if (index < 0) {
        tmpI = [_bigArray count]-1;
    }
    if (index >= [_bigArray count]) {
        tmpI = 0;
    }
    
    ALAsset *s = [_bigArray objectAtIndex:tmpI];
    return  [UIImage imageWithCGImage:s.defaultRepresentation.fullScreenImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)initView
{
    

    
}

-(CGRect)getImageViewFrameWithSize:(CGSize)size
{
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - size.height)/2;
    if (y < 0) {
        y = 0;
    }
    return CGRectMake(0, y, size.width, size.height);
    
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(CGPoint)contentOffsetForIndex:(NSInteger)Index
{
    CGFloat x = CGRectGetWidth(self.view.bounds)*(Index);
    return CGPointMake(x+(Index+1)*ViewSpace, 0);
}

-(void)reFreashShowImageIndex:(NSInteger)index
{
    [leftIamgeView setImage:[self getBigImageFromIndex:index-1]];
    [_midIamgeView setImage:[self getBigImageFromIndex:index]];
    [rightIamgeView setImage:[self getBigImageFromIndex:index+1]];
}

- (BOOL)prefersStatusBarHidden
{
    return bShowBar;//隐藏为YES，显示为NO
}

//
-(CGRect)blackFrameWithX:(CGFloat)x
{
    CGFloat offset = (x-SCREEN_W)*0.1;
    if (x > SCREEN_W) {
    
        return CGRectMake(SCREEN_W*2-offset, 0, SCREEN_W*0.1, SCREEN_H);
    }
    else
    {
        return CGRectMake(SCREEN_W-SCREEN_W*0.1-offset, 0, SCREEN_W*0.1, SCREEN_H);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    _blackView.frame = [self blackFrameWithX:offsetX];
    
}

-(void)scrollToIndex:(NSInteger)index
{
    
    if (index == 2) {
        _currentIndex++;
        
    }
    else if(index == 0)
    {
        _currentIndex--;
    }
    
    if (_currentIndex < 0) {
        _currentIndex = _currentIndex % [_bigArray count]+[_bigArray count];
    }
    [self reFreashShowImageIndex:_currentIndex % [_bigArray count]];
    [titleLabel setText:[NSString stringWithFormat:@"%ld/%ld",_currentIndex,[_bigArray count]]];
    [_sv setContentOffset:[self contentOffsetForIndex:1] animated:NO];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = scrollView.contentOffset.x/(CGRectGetWidth(_sv.bounds)+ViewSpace*2);
    [self scrollToIndex:_index];
}

-(void)setImagesNull
{

    leftIamgeView = nil;
    _midIamgeView = nil;
    rightIamgeView = nil;
    
}

-(void)tap:(UITapGestureRecognizer *)Zoomview
{
   // [self setImagesNull];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

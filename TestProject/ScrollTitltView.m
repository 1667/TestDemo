//
//  ScrollTitltView.m
//  TTTT
//
//  Created by innke on 15/9/12.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import "ScrollTitltView.h"


@interface ScrollTitltView() <UIScrollViewDelegate>

@end

@implementation ScrollTitltView
{
    CGFloat btnW;
    CGFloat selfW;
    CGFloat vH;
    CGFloat btnH;
    
    NSMutableArray *frameArray;
    UIScrollView *_scrollView;
    
}
-(instancetype)initWithFrame:(CGRect)frame titleText:(NSArray *)titleArray viewArray:(NSMutableArray *)vA
{
    self = [super  initWithFrame:frame];
    if (self) {
        
        _titleArray = titleArray;
        _titleBtnArray = [NSMutableArray new];
        _viewArray = vA;
        frameArray = [NSMutableArray new];
        [self initView];
    }
    return self;
}

-(void)initView
{
    btnW = self.frame.size.width/[_titleArray count];
    CGFloat x = 0;
    btnH = BTN_H;
    vH = self.frame.size.height-btnH;
    selfW = self.frame.size.width;
    _flagView = [[UIView alloc] initWithFrame:CGRectMake(10, btnH-2, btnW-20, 2)];
    [_flagView setBackgroundColor:[UIColor redColor]];
    [self addSubview:_flagView];
    NSInteger tag = 0;
    for (NSString *str in _titleArray) {
        CGRect frame = CGRectMake(x, 0, btnW, btnH);
        [frameArray addObject:[NSValue valueWithCGRect:frame]];
        UIButton *tmp = [self createBtnWithFrame:frame title:str];
        tmp.tag = tag;
        if (tag == 0) {
            [tmp setSelected:YES];
        }
        tag++;
        [_titleBtnArray addObject:tmp];
        [self addSubview:tmp];
        x += btnW;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, btnH+1, self.frame.size.width, self.frame.size.height-btnH)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    x = 0;
    
    for (UIView *v in _viewArray) {
        v.frame = CGRectMake(x, 0, selfW, vH);
        x += selfW;
        [_scrollView addSubview:v];
    };
    [_scrollView setContentSize:CGSizeMake(x, vH)];
}

-(void)setTitleWithID:(NSInteger)ID str:(NSString *)str
{
    
    
        UIButton *tagBtn = (UIButton *)[_titleBtnArray objectAtIndex:ID];
        [tagBtn setTitle:str forState:UIControlStateNormal];

    
    
}

-(CGRect)valueToFrame:(NSValue *)value
{
    return [value CGRectValue];
}

-(UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)str
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    return btn;
    
}

-(void)swipFlagTo:(NSInteger)pos
{
    UIButton *tmp = nil;
    for (UIButton *btn in _titleBtnArray) {
        [btn setSelected:NO];
        if (btn.tag == pos) {
            tmp = btn;
        }
    }
    [tmp setSelected:YES];
    CGRect frame = CGRectMake(btnW*pos+10, btnH-2, btnW-20, 2);
    [UIView animateWithDuration:0.3 animations:^{
        _flagView.frame = frame;
    }];
}

-(void)titleClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self swipFlagTo:btn.tag];
    [self swipScrollToPage:btn.tag];
}

-(void)swipScrollToPage:(NSInteger)page
{
    [_scrollView setContentOffset:CGPointMake(page*selfW, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x/selfW;
    [self swipFlagTo:page];
}

@end

//
//  ScrollTitltView.h
//  TTTT
//
//  Created by innke on 15/9/12.
//  Copyright (c) 2015年 wuxianying. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTN_H       40

@interface ScrollTitltView : UIView


-(instancetype)initWithFrame:(CGRect)frame titleText:(NSArray *)titleArray viewArray:(NSMutableArray *)vA;
-(void)setTitleWithID:(NSInteger)ID str:(NSString *)str;

@property (nonatomic,strong) NSArray        *titleArray;
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,strong) UIView         *flagView;

@end

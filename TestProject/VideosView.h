//
//  VideosView.h
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosView : UIView


@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *urlarray;
@property (nonatomic,strong)UIViewController *superVc;

-(void)refreashView;

@end

//
//  ImagesView.h
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ImagesView : UIView

@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *bigImageArray;
@property (nonatomic,strong)BaseViewController *superVc;



-(void)refreashView;

@end

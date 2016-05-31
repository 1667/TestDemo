//
//  NewImageViewViewController.h
//  TestProject
//
//  Created by wxy on 15/11/19.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZoomImageView.h"

@interface NewImageViewViewController : UIViewController

@property (nonatomic,assign)NSInteger           startIndex;
@property (nonatomic,strong)NSMutableArray      *bigArray;
@property (nonatomic,strong)UIImageView         *selectImageView;
@property (nonatomic,strong)UIImage             *selectImage;
@property (nonatomic,strong)ZoomImageView       *midIamgeView;
@property (nonatomic,assign)CGRect              fromeframe;

@end

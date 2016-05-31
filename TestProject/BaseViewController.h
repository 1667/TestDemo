//
//  BaseViewController.h
//  TTTT
//
//  Created by 无线盈 on 15/9/10.
//  Copyright (c) 2015年 无线盈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "Utils.h"

#define BACK_STR        @"jpg"

#define ADDVIEW_TITLE_H         50

@interface BaseViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UIView             *selfView;

@property (nonatomic,strong) UIView             *titleView;
@property (nonatomic,strong) UIButton           *leftBtn;
@property (nonatomic,strong) UIButton           *rightBtn;

@property (nonatomic,strong) UIView             *currentView;

@property (nonatomic,assign) CGFloat            keyboardHieght;
@property (nonatomic,assign) CGFloat            selfViewWidth;
@property (nonatomic,assign) CGFloat            selfViewHieght;
@property (nonatomic,assign) CGRect             selfFrame;

@property (nonatomic,assign) BOOL               bEdit;
@property (nonatomic,assign) BOOL               bNeedRefresh;
@property (nonatomic,assign) BOOL               isHaveDian;

-(void)setTitleText:(NSString *)text;

-(void)right:(id)sender;
-(void)left:(id)sender;

-(void)textFieldDidBeginEditing:(UITextField *)textField;

-(void)showActionSheetWithTitle:(NSString *)str cancelBtnTitle:(NSString *)cancelTitle btnArray:(NSMutableArray *)arr tag:(NSInteger)tag;
-(void)showSelectPhotoActionSheet;

-(void)showAlterViewWithTag:(NSInteger)tag Tiltle:(NSString *)title message:(NSString *)mess canelBtnTitle:(NSString *)cancel otherBtnArr:(NSArray *)arr;
-(void)showDataHolder:(BOOL)bshow;
-(void)showAlterViewWithText:(NSString *)title;

-(void)initNoDataHolderWithStr:(NSString *)str;

-(void)keyboardEditDidShow:(NSNotification *)notification;
-(void)keyboardEditDidHide:(NSNotification *)notification;

@end

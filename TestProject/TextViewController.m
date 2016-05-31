//
//  TextViewController.m
//  TestProject
//
//  Created by wxy on 15/11/27.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "TextViewController.h"
#import "Utils.h"
#import "UIImage+LocalSize.h"

@interface TextViewController ()

@end

@implementation TextViewController
{
    UITextView      *_textView;
    NSString        *_str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    _str = @"这是标题\n这是第二行  这是第2列\n正题阿斯顿发生大发撒放大离开家撒旦法按时付款就阿里；双方均asfasdfasfdalkjsflakj阿斯顿发生大发撒旦法asdfasdfaasfdaasa撒旦法；拉斯克奖发了奥斯卡奖罚洛杉矶的法律；看见谁发的阿斯利康就发；了数据库等法律按实际开发；阿里就开始放到了；安家费阿里山科技发达了开始将对方拉开始交电费了卡双方的空间啊发送卡飞机阿里开始就放暑假了罚款就是浪费\n\n\n\n\n";

    [self.view setBackgroundColor:[UIColor whiteColor]];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), SCREEN_W, SCREEN_H-NAV_STATUS_H(self))];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.text = _str;
    _textView.font = SYS_FONT_SIZE(14);
    _textView.editable = NO;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    [self setNormalAttribute];
    [self setImageIn];
}

-(void)setNormalAttribute
{
    NSMutableAttributedString *mutStr = [_textView.attributedText mutableCopy];
    NSArray *array = [_str componentsSeparatedByString:@"\n"];
    NSString *tmpStr = (NSString *)array[0];
    [mutStr addAttribute:NSFontAttributeName value:SYS_FONT_SIZE(40) range:NSMakeRange(0, tmpStr.length)];
    tmpStr = (NSString*)array[1];
    [mutStr addAttribute:NSFontAttributeName value:SYS_FONT_SIZE(20) range:NSMakeRange(((NSString *)array[0]).length+1, ((NSString *)array[1]).length)];
    
    _textView.attributedText = [mutStr copy];
    
}

-(void)setImageIn
{
    NSMutableAttributedString *mutStr = [_textView.attributedText mutableCopy];
    
    UIImage *image = [UIImage imageNamed:@"tu8601_10.jpg"];
    NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
    attachment1.bounds = CGRectMake(0, 0, _textView.frame.size.width-10, [image localImageSizeWithWidth:SCREEN_W].height);
    attachment1.image = image;
    NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
    [mutStr insertAttributedString:attachStr1 atIndex:_str.length-3];
    
    UIImage *image2 = [UIImage imageNamed:@"tu8601_7.jpg"];
    NSTextAttachment * attachment2 = [[NSTextAttachment alloc] init];
    attachment2.bounds = CGRectMake(0, 0, _textView.frame.size.width-10, [image2 localImageSizeWithWidth:SCREEN_W].height);
    attachment2.image = image2;
    NSAttributedString * attachStr2 = [NSAttributedString attributedStringWithAttachment:attachment2];
    [mutStr insertAttributedString:attachStr2 atIndex:_str.length];
    
    _textView.attributedText = [mutStr copy];
}

-(void)setImage
{
    CGSize size = _textView.attributedText.size;
    [Utils NSLogWrite:[NSValue valueWithCGSize:size] Str:@"sttSize"];
    
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tu8601_10.jpg"]];
    CGRect rect = CGRectMake(0, size.height+20, SCREEN_W, [image.image localImageSizeWithWidth:SCREEN_W].height+300);
    image.frame = rect;
    [_textView addSubview:image];
    [Utils NSLogWrite:[NSValue valueWithCGRect:rect] Str:@"rect "];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
    _textView.textContainer.exclusionPaths = @[path];
    
}

@end

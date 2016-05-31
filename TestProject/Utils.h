//
//  Utils.h
//  TTTT
//
//  Created by innke on 15/9/20.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "UIImage+LocalSize.h"
#import "GlobalModel.h"

#define VC_W(vc)               (vc.view.frame.size.width)
#define VC_H(vc)               (vc.view.frame.size.height)

#define SCREEN_W               ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H               ([UIScreen mainScreen].bounds.size.height)

#define HALF_SCREEN_W             (SCREEN_W/2)
#define HALF_SCREEN_H             (SCREEN_H/2)

#define RANDOM_COLOR            [Utils randomColor]
#define WHITE_COLOR             [UIColor whiteColor]
#define CLEAR_COLOR             [UIColor clearColor]


#define STATUS_H                ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NAV_H(vc)               (vc.navigationController.navigationBar.frame.size.height)

#define NAV_STATUS_H(vc)        (NAV_H(vc)+STATUS_H)

#define IMAGE_CUP               @"tu8601_7.jpg"
#define IMAGE_CAMREA               @"tu8601_5.jpg"
#define IMAGE_ICE_CRE               @"tu8601_10.jpg"

#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)

#define FILE_CACHE_DIC                          [NSHomeDirectory() stringByAppendingString:@"/Documents/Cache"]
#define FILE_CACHE_PATH_DIC                     [NSHomeDirectory() stringByAppendingString:@"/Documents/Cache/"]
#define FILE_FLAGES_URL(userid)                [FILE_CACHE_PATH_DIC stringByAppendingString:[NSString stringWithFormat:@"%@%@",userid,@"urlVedio"]]

#define SYS_FONT_SIZE(s)  [UIFont systemFontOfSize:s]

/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 * 示例：
 * @weakify_self
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif
/**
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 * 示例：
 * @weakify(object)
 * [obj block:^{
 * @strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif

@interface Utils : NSObject

+(UIColor *)randomColor;
+(UIImage *) createImageWithColor: (UIColor *) color;

+(BOOL)setLocalCache:(NSDictionary *)dic Flage:(NSString *)flage;
+(NSDictionary *)getLocalCache:(NSString *)flage;
+(BOOL)setLocalCacheWithObjct:(NSObject *)obj Flage:(NSString *)flage;

+(void)pauseLayer:(CALayer*)layer;
+(void)resumeLayer:(CALayer*)layer;

+(CGRect)getImageViewFrameWithSize:(CGSize)size;
+(void)NSLogWrite:(id)data Str:(NSString *)str;

@end

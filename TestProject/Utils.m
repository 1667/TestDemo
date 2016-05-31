//
//  Utils.m
//  TTTT
//
//  Created by innke on 15/9/20.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "Utils.h"
#import <objc/runtime.h>

@implementation Utils

+(Utils*)instance
{
    static dispatch_once_t onceToken;
    static Utils *util;
    
    dispatch_once(&onceToken,^{
        util = [[Utils alloc] init];
    });
    return  util;
}

+(UIColor *)randomColor
{
    CGFloat r = arc4random()%256 / 255.0f;
    CGFloat g = arc4random()%256 / 255.0f;
    CGFloat b = arc4random()%256 / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
    
}

+(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(NSDictionary*)getObjectData:(id)obj

{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++)
        
    {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        
        if(value  == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
        
    }
    return dic;
    
}


+(void)print:(id)obj

{
    
    NSLog(@"%@",[self getObjectData:obj]);
    
}
+(NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error

{
    
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
    
}

+(id)getObjectInternal:(id)obj
{
    
    if([obj isKindOfClass:[NSString class]] ||  [obj isKindOfClass:[NSNumber class]] ||  [obj isKindOfClass:[NSNull class]])
    {
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]])
        
    {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return  arr;
        
    }
    if([obj isKindOfClass:[NSDictionary class]])
        
    {
        
        NSDictionary  *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys)
        {
            
            [dic  setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
            
        }
        return  dic;
    }
    return [self getObjectData:obj];
}


+(BOOL)setLocalCacheWithObjct:(NSObject *)obj Flage:(NSString *)flage
{
    NSDictionary * tmpDic = [Utils getObjectData:obj];
    return [tmpDic writeToFile:flage atomically:YES];
}

+(BOOL)setLocalCache:(NSDictionary *)dic Flage:(NSString *)flage
{
    return [dic writeToFile:flage atomically:YES];
}

+(NSDictionary *)getLocalCache:(NSString *)flage
{
    return [NSDictionary dictionaryWithContentsOfFile:flage];
}

+(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

+(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

+(CGRect)getImageViewFrameWithSize:(CGSize)size
{
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - size.height)/2;
    if (y < 0) {
        y = 0;
    }
    NSLog(@"size %@ resenct %@",[NSValue valueWithCGSize:size],[NSValue valueWithCGRect:CGRectMake(0, y, size.width, size.height)]);
    return CGRectMake(0, y, size.width, size.height);
    
}

+(void)NSLogWrite:(id)data Str:(NSString *)str
{
    NSLog(@"%@---%@",str,data);
}

@end

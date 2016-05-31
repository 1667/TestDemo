//
//  SystemImageViewController.m
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "SystemImageViewController.h"
#import "ScrollTitltView.h"
#import "ImagesView.h"
#import "Utils.h"
#import "VideosView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#import "CustomPushAnimation.h"
#import "CustomPopAnimation.h"
#import "CustomPanAnimation.h"


// 照片原图路径
#define KOriginalPhotoImagePath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]

// 视频URL路径
#define KVideoUrlPath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]

// caches路径
#define KCachesPath   \
[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface SystemImageViewController () <UINavigationControllerDelegate>


@property (nonatomic,strong) NSMutableArray        *totalArrays;
@property (nonatomic,strong) NSMutableArray        *imageArrays;
@property (nonatomic,strong) NSMutableArray        *VideoArrays;
@property (nonatomic,strong) CustomPanAnimation      *panAnimation;
@property (nonatomic,strong) CustomPopAnimation      *popAnimation;
@end

@implementation SystemImageViewController
{
    ScrollTitltView         *scrollTitle;
    ImagesView              *_imageView;
    VideosView              *_videoView;
    ALAssetsLibrary         *_assetsLibrary;
    
    BOOL                    bStop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.totalArrays = [NSMutableArray array];
    self.imageArrays = [NSMutableArray array];
    self.VideoArrays = [NSMutableArray array];
    
    self.navigationController.delegate = self;
    NSMutableArray *vA = [NSMutableArray new];
    
    CGRect frame = CGRectMake(0, NAV_STATUS_H(self)+BTN_H, self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)-BTN_H);
    
    _imageView = [[ImagesView alloc] initWithFrame:frame];
    _imageView.superVc = self;
    [vA addObject:_imageView];
    
    _videoView = [[VideosView alloc] initWithFrame:frame];
    _videoView.superVc = self;
    [vA addObject:_videoView];
    
    scrollTitle = [[ScrollTitltView alloc] initWithFrame:CGRectMake(0, NAV_STATUS_H(self), self.view.frame.size.width, self.view.frame.size.height-NAV_STATUS_H(self)) titleText:@[@"相册",@"视频"] viewArray:vA];
    [self.view addSubview:scrollTitle];
    [self testRun];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testRun
{
    [_imageView.imageArray removeAllObjects];
    [_videoView.array removeAllObjects];
    __weak SystemImageViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
         __strong SystemImageViewController *strongSelf = weakSelf;
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
                
                NSString *g1=[g substringFromIndex:16 ] ;
                NSArray *arr=[[NSArray alloc] init];
                arr=[g1 componentsSeparatedByString:@","];
                NSString *g2=[[arr objectAtIndex:0] substringFromIndex:5];
                if ([g2 isEqualToString:@"Camera Roll"]) {
                    g2=@"相机胶卷";
                }
                NSString *groupName=g2;//组的name
                NSLog(@"groupName %@ tttt",groupName);
                [strongSelf.totalArrays addObject:group];
            } else {
                NSLog(@"iiiiiiiiiiiiiii");
                [strongSelf.totalArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        if ([result thumbnail] != nil) {
                            // 照片
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                                
                                ALAsset *tmpAL = [[ALAsset alloc] init];
                                tmpAL = result;
                                //UIImage *image = [UIImage imageWithCGImage:[result thumbnail]];//缩略图
                                //image = [UIImage imageWithCGImage:[result defaultRepresentation].fullScreenImage];//大图
                                //[_imageView.imageArray addObject:image];
                                [_imageView.bigImageArray addObject:tmpAL];
//                                 NSDate *date= [result valueForProperty:ALAssetPropertyDate];
//                                NSString *fileName = [[result defaultRepresentation] filename];
//                                NSURL *url = [[result defaultRepresentation] url];
//                                int64_t fileSize = [[result defaultRepresentation] size];
                                
                               // NSLog(@"date = %@",date);
//                                NSLog(@"fileName = %@",fileName);
//                                NSLog(@"url = %@",url);
//                                NSLog(@"fileSize = %lld",fileSize);
//
                                // UI的更新记得放在主线程,要不然等子线程排队过来都不知道什么年代了,会很慢的
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [_imageView refreashView];
                                    [scrollTitle setTitleWithID:0 str:[NSString stringWithFormat:@"相片(%ld)",_imageView.bigImageArray.count]];
                                });
                            }
                            // 视频
                            else if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo] ){
                                
                                // 和图片方法类似
                                UIImage *image = [UIImage imageWithCGImage:[result thumbnail]];
                                NSURL *url = [[result defaultRepresentation] url];
                                
                                [_videoView.urlarray addObject:url];
                                [_videoView.array addObject:image];
                                // UI的更新记得放在主线程,要不然等子线程排队过来都不知道什么年代了,会很慢的
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [_videoView refreashView];
                                    
                                    [scrollTitle setTitleWithID:1 str:[NSString stringWithFormat:@"视频(%ld)",_videoView.array.count]];
                                });
                            }
                        }
                    }];
                    
                }];
                
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
        {
            
            NSString *errorMessage = nil;
            
            switch ([error code]) {
                case ALAssetsLibraryAccessUserDeniedError:
                case ALAssetsLibraryAccessGloballyDeniedError:
                    errorMessage = @"用户拒绝访问相册,请在<隐私>中开启";
                    break;
                    
                default:
                    errorMessage = @"Reason unknown.";
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误,无法访问!"
                                                                   message:errorMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil, nil];
                [alertView show];
            });
        };
        
        
        _assetsLibrary = [[ALAssetsLibrary alloc]  init];
        [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                     usingBlock:listGroupBlock failureBlock:failureBlock];
        
        
    });
    
    
}


- (void)imageWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    // 进这个方法的时候也应该加判断,如果已经转化了的就不要调用这个方法了
    // 如何判断已经转化了,通过是否存在文件路径
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    // 创建存放原始图的文件夹--->OriginalPhotoImages
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:KOriginalPhotoImagePath]) {
        [fileManager createDirectoryAtPath:KOriginalPhotoImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            // 主要方法
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:fileName];
                [data writeToFile:imagePath atomically:YES];
            } failureBlock:nil];
        }
    });
}

// 将原始视频的URL转化为NSData数据,写入沙盒
- (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    // 解析一下,为什么视频不像图片一样一次性开辟本身大小的内存写入?
    // 想想,如果1个视频有1G多,难道直接开辟1G多的空间大小来写?
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (url) {
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                NSString * videoPath = [KCachesPath stringByAppendingPathComponent:fileName];
                char const *cvideoPath = [videoPath UTF8String];
                FILE *file = fopen(cvideoPath, "a+");
                if (file) {
                    const int bufferSize = 11024 * 1024;
                    // 初始化一个1M的buffer
                    Byte *buffer = (Byte*)malloc(bufferSize);
                    NSUInteger read = 0, offset = 0, written = 0;
                    NSError* err = nil;
                    if (rep.size != 0)
                    {
                        do {
                            read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                            written = fwrite(buffer, sizeof(char), read, file);
                            offset += read;
                        } while (read != 0 && !err);//没到结尾，没出错，ok继续
                    }
                    // 释放缓冲区，关闭文件
                    free(buffer);
                    buffer = NULL;
                    fclose(file);
                    file = NULL;
                }
            } failureBlock:nil];
        }
    });
}

+(UIImage *)getImage:(NSString *)videoURL

{
    
    //视频地址
    
    NSURL *url = [[NSURL alloc] initWithString:videoURL];//initFileURLWithPath:videoURL] autorelease];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
    
    //获取视频时长，单位：秒
    
    NSLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    
    
    generator.appliesPreferredTrackTransform = YES;
    
    generator.maximumSize = CGSizeMake(1136, 640);
    
    NSError *error = nil;
    
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
    
    UIImage *image = [UIImage imageWithCGImage: img];
    
    return image;  
    
}

-(void)left:(id)sender
{
    self.navigationController.delegate = nil;
    [super left:sender];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:
            return [[CustomPushAnimation alloc] init];
        case UINavigationControllerOperationPop:
            return self.popAnimation;
        default:
            break;
    }
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.panAnimation.isActing ? self.panAnimation : nil;
}

-(void)writePanAnimationToVC:(UIViewController *)vc
{
    [self.panAnimation writeToViewContorller:vc];
}

-(CustomPanAnimation *)panAnimation
{
    if (!_panAnimation) {
        _panAnimation = [[CustomPanAnimation alloc] init];
        _panAnimation.customPop = self.popAnimation;
    }
    return _panAnimation;
}

-(CustomPopAnimation*)popAnimation
{
    if (!_popAnimation) {
        _popAnimation = [[CustomPopAnimation alloc] init];
        
    }
    return _popAnimation;
}

//- (UIImage *)imageWithMediaURL:(NSURL *)url {
//    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
//                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
//    // 初始化媒体文件
//    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
//    // 根据asset构造一张图
//    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
//    // 设定缩略图的方向
//    // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
//    generator.appliesPreferredTrackTransform = YES;
//    // 设置图片的最大size(分辨率)
//    generator.maximumSize = CGSizeMake(600, 450);
//    // 初始化error
//    NSError *error = nil;
//    // 根据时间，获得第N帧的图片
//    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
//    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
//    // 构造图片
//    UIImage *image = [UIImage imageWithCGImage: img];
//    return image;
//}

@end

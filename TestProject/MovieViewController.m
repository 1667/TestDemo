//
//  MovieViewController.m
//  TTTT
//
//  Created by 无线盈 on 15/10/9.
//  Copyright © 2015年 wuxianying. All rights reserved.
//

#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Utils.h"

@interface MovieViewController ()

@property (nonatomic,strong)MPMoviePlayerController *movieVc;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation MovieViewController
{

    BOOL                        stauts_bar_hiden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addMoive];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMoive
{
    NSURL *videoUrl = nil;
    
    if (_videourl == nil) {
        
        NSString *url = _videoPath;
        videoUrl = [NSURL fileURLWithPath:url];
        
    }
    else
    {
        videoUrl = _videourl;
    }
    _movieVc =[[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissmiss:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:_movieVc name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loading:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [_movieVc prepareToPlay];
    _movieVc.controlStyle = MPMovieControlStyleFullscreen;
    [_movieVc setFullscreen:YES animated:YES];
    [_movieVc.view setFrame:self.view.bounds];
    [self.view addSubview:_movieVc.view];
    
    [self playerViewDelegateSetStatusBarHiden:NO];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [self.view addSubview:self.activityIndicator];
    _activityIndicator.center = _movieVc.view.center;
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.activityIndicator startAnimating];
    [self.view bringSubviewToFront:_activityIndicator];
    
}

-(void)play
{
    
}

-(void)playerViewDelegateSetStatusBarHiden:(BOOL)is_hiden
{
    [[UIApplication sharedApplication] setStatusBarHidden:is_hiden withAnimation:UIStatusBarAnimationSlide];
    
}

-(void)loading:(NSNotification *)not
{
    
    [_activityIndicator removeFromSuperview];
}

-(void)dissmiss:(NSNotification *)not
{
    NSDictionary *ui = not.userInfo;
    NSLog(@"%@",ui);
    NSInteger i = [[ui objectForKey:@"MPMoviePlayerPlaybackDidFinishReasonUserInfoKey"] integerValue];
    if (i == 2) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    [self playerViewDelegateSetStatusBarHiden:NO];
}

@end

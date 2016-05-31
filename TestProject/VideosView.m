//
//  VideosView.m
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "VideosView.h"
#import "Utils.h"
#import "ImageCollectionViewCell.h"
#import "MovieViewController.h"

#define _kImageCount        3
#define _kOffset            5
#define _kImageWidth        ((SCREEN_W-(_kImageCount+1)*_kOffset)/_kImageCount)

@interface VideosView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation VideosView
{
    UICollectionView        *_collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = [NSMutableArray array];
        _urlarray = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    
}

-(void)refreashView
{
    [_collectionView reloadData];
    
}

-(void)showVideoWithUrl:(NSURL *)url
{
    MovieViewController *movieVC = [MovieViewController new];
    movieVC.videourl = url;
    movieVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [_superVc.navigationController presentViewController:movieVC animated:YES completion:^{
        
    }];
    
}

#pragma mark Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.bVideo = YES;
    cell.imageView.image = [_array objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_kImageWidth, _kImageWidth);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(_kOffset/2, _kOffset/2, _kOffset/2, _kOffset/2);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showVideoWithUrl:[_urlarray objectAtIndex:indexPath.row]];
}

@end

//
//  ImagesView.m
//  TestProject
//
//  Created by wxy on 15/11/9.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "ImagesView.h"
#import "ImageCollectionViewCell.h"
#import "Utils.h"
#import "ImageViewViewController.h"
#import "NewImageViewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CustomPushAnimation.h"
#import "SystemImageViewController.h"

#define _kImageCount        4
#define _kOffset            5
#define _kImageWidth        ((SCREEN_W-(_kImageCount+1)*_kOffset)/_kImageCount)

@interface ImagesView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ImagesView
{
    UICollectionView        *_collectionView;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = [NSMutableArray array];
        _bigImageArray = [NSMutableArray array];
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
    NSLog(@"%@ttt",[NSValue valueWithCGRect:self.bounds]);
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

#pragma mark Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _bigImageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ALAsset *set = [_bigImageArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:[set thumbnail]];
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
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NewImageViewViewController *tmpVc = [NewImageViewViewController new];
    tmpVc.startIndex = indexPath.row;
    tmpVc.bigArray = _bigImageArray;
    tmpVc.fromeframe = [_collectionView convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];

    
    tmpVc.selectImageView = cell.imageView;
    ALAsset *set = [_bigImageArray objectAtIndex:indexPath.row];
    tmpVc.selectImage = [UIImage imageWithCGImage:[set defaultRepresentation].fullScreenImage];
    SystemImageViewController *tmpSys = (SystemImageViewController *)_superVc;
    [tmpSys writePanAnimationToVC:tmpVc];
    [_superVc.navigationController pushViewController:tmpVc animated:YES];
    
}

@end

//
//  AutoHightTableViewCell.m
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "AutoHightTableViewCell.h"

@implementation AutoHightTableViewCell
{
    UILabel *lable;
    UIImageView *image;
    CGSize      size1;
    CGSize      size2;
    CGSize      size3;
    NSMutableArray  *imageArray;
    NSMutableArray  *sizeArray;
    
}
- (void)awakeFromNib {
    // Initialization code
}

-(UIImageView *)view1
{
    if (!_view1) {
        
        _view1 = [UIImageView new];
        [self.contentView addSubview:_view1];
        
    }
    return _view1;
}


-(UIImageView *)view2
{
    if (!_view2) {
        
        _view2 = [UIImageView new];
        [self.contentView addSubview:_view2];
        
    }
    return _view2;
}

-(UIImageView *)view3
{
    if (!_view3) {
        
        _view3 = [UIImageView new];
        [self.contentView addSubview:_view3];
        
    }
    return _view3;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageArray = [NSMutableArray new];
        [self initView];
        
    }
    return self;
}

-(void)initView
{
    lable = [UILabel new];
    lable.numberOfLines = 4;
    lable.preferredMaxLayoutWidth = SCREEN_W-30;
    [self.contentView addSubview:lable];
    CGFloat btnW = (SCREEN_W-40)/3;
    
    
    image = [UIImageView new];
    [image setImage:[UIImage imageNamed:@"tu8601_10.jpg"]];
    [self.contentView addSubview:image];
    
    [image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.top.equalTo(self.contentView.top).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_W*0.1, SCREEN_W*0.1));
        make.bottom.lessThanOrEqualTo(self.contentView.bottom).offset(-10).priorityLow();
    }];
    
    [lable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(SCREEN_W*0.1+20);
        make.right.equalTo(self.contentView.right).offset(-10);
        make.top.equalTo(image.top).offset(10);
        //make.bottom.lessThanOrEqualTo(self.contentView.bottom).offset(-10);
    }];
    
    [self.view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lable.bottom).offset(10);
        make.bottom.lessThanOrEqualTo(self.contentView.bottom).offset(-10).priorityLow();
        make.left.equalTo(lable.left);
        
    }];
    
    [self.view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1);
        //make.bottom.equalTo(self.view1);
        make.left.equalTo(self.view1.right);
        
    }];
//
    [self.view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view1);
        //make.bottom.equalTo(self.view1);
        make.left.equalTo(self.view2.right);
        
    }];
    
    [imageArray addObject:self.view1];
    [imageArray addObject:self.view2];
    [imageArray addObject:self.view3];
    
}

-(void)updateConstraints
{
    [self.view1 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(size1);
        
    }];
    
    [self.view2 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(size2);
    }];
//
    [self.view3 updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(size3);
    }];
    
    [super updateConstraints];
    
}

-(void)hideImage:(NSInteger)cout
{
    if (cout == 0) {
        self.view1.hidden = YES;
        self.view2.hidden = YES;
        self.view3.hidden = YES;
    }
    if (cout == 1) {
        self.view1.hidden = NO;
        self.view2.hidden = YES;
        self.view3.hidden = YES;
    }
    if (cout == 2) {
                self.view1.hidden = NO;
                self.view2.hidden = NO;
        self.view3.hidden = YES;
    }
    
    if (cout == 3) {
        self.view1.hidden = NO;
        self.view2.hidden = NO;
        self.view3.hidden = NO;
    }
}

-(CGFloat)getW:(NSInteger)cout
{
    
    if (cout == 1) {
        return SCREEN_W*0.9-30;
    }
    if (cout == 2) {
        return (SCREEN_W*0.9-40)/2;
    }

    if (cout == 3) {
        return (SCREEN_W*0.9-50)/3;
    }
    return (SCREEN_W*0.9-50)/3;
    
}

-(void)setSizesW:(NSInteger)count ImageNames:(NSMutableArray *)imageNameArray
{
    switch (count) {
        case 1:
        {
            size1 = [self getImageSizeWithName:[imageNameArray objectAtIndex:0] withWidth:[self getW:count]];
            [self.view1 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:0]]];
            size2 = CGSizeZero;
            size3 = CGSizeZero;
            
        }

            break;
            case 2:
        {
            size1 = [self getImageSizeWithName:[imageNameArray objectAtIndex:0] withWidth:[self getW:count]];
            [self.view1 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:0]]];
            size2 = [self getImageSizeWithName:[imageNameArray objectAtIndex:1] withWidth:[self getW:count]];
            size2.height = size1.height;
            [self.view2 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:1]]];
            size3 = CGSizeZero;

        }
            break;
            case 3:
        {
            size1 = [self getImageSizeWithName:[imageNameArray objectAtIndex:0] withWidth:[self getW:count]];
            [self.view1 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:0]]];
            size2 = [self getImageSizeWithName:[imageNameArray objectAtIndex:1] withWidth:[self getW:count]];
            size2.height = size1.height;
            [self.view2 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:1]]];
            size3 = [self getImageSizeWithName:[imageNameArray objectAtIndex:2] withWidth:[self getW:count]];
            size3.height = size1.height;
            [self.view3 setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:2]]];
        }
            break;
        default:
            break;
    }
}

-(CGSize)getImageSizeWithName:(NSString *)name withWidth:(CGFloat)w
{
    UIImage *limage = [UIImage imageNamed:name];
    CGSize size = [limage localImageSizeWithWidth:w];
    return size;
}

-(void)setViewWithData:(GlobalModel *)model
{
    lable.text = model.str;
    NSMutableArray *imageS = model.imageArray;
    [self hideImage:[imageS count]];
    
    if ([imageS count] != 0) {
        [self setSizesW:[imageS count] ImageNames:imageS];
        
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
    
    
}


@end

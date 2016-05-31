//
//  AutoHightViewController.m
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "AutoHightViewController.h"
#import "AutoHightTableViewCell.h"
#import "GlobalModel.h"

#define NUM_ARR             30

@interface AutoHightViewController ()<UITableViewDelegate,UITableViewDataSource,AutoHeightCellDelegate>

@end

@implementation AutoHightViewController
{
    UITableView             *_tableView;
    AutoHightTableViewCell  *_cell;
    NSMutableArray          *_data;
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
    _data = [NSMutableArray new];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"tu8601_5.jpg",@"tu8601_7.jpg",@"tu8601_10.jpg",@"tu8601_10.jpg", nil];
    
    for(int i = 0; i < NUM_ARR; i++)
    {
     
        GlobalModel *model = [GlobalModel new];
        
        NSMutableArray *imagearray = [NSMutableArray new];
        NSInteger imageCount = [self getRandom];
        NSMutableString *str1 = [NSMutableString new];
        for (int k = 0; k < imageCount; k++) {
            [imagearray addObject:[array objectAtIndex:[self getRandom]-1]];
            [str1 appendString:[imagearray objectAtIndex:k]];
        }
        model.imageArray = imagearray;
        
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"%d %@",i,str1];
        for (int j = 0; j < i; j++) {
            [str appendString:@"f覅抵抗力费fdsafea覅抵抗力费fdsafea"];
        }
        model.str = str;
        
        [_data addObject:model];
        
    }
    
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[AutoHightTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(NAV_STATUS_H(self), 0, 0, 0));
    }];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_cell) {
        _cell = [[AutoHightTableViewCell alloc] init];
    }
    
    [_cell setViewWithData:[_data objectAtIndex:indexPath.row]];
    
//    [_cell setNeedsLayout];
//    [_cell layoutIfNeeded];

    CGSize size = [_cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoHightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.delegate = self;
    [cell setViewWithData:[_data objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(NSInteger)getRandom
{
    NSInteger tmp = arc4random() % 4;
    while (tmp == 0) {
        tmp = arc4random() % 4;
    }
    return tmp;
}





@end

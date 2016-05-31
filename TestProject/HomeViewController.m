//
//  HomeViewController.m
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "HomeViewController.h"
#import "Utils.h"
#import "UITestSwipCellViewController.h"
#import "AutoHightViewController.h"
#import "SystemImageViewController.h"
#import "ModelViewController.h"
#import "TextViewController.h"
#import "BottomInputViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomeViewController
{
    UITableView *_tableView;
    
    NSMutableArray          *arrData;
    NSMutableArray          *vcArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    arrData = [NSMutableArray new];
    vcArr = [NSMutableArray new];
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addTableCellWithTitle:@"左滑删除" VC:[UITestSwipCellViewController class]];
    [self addTableCellWithTitle:@"自适应高度" VC:[AutoHightViewController class]];
    [self addTableCellWithTitle:@"系统图片和视频" VC:[SystemImageViewController class]];
    [self addTableCellWithTitle:@"模态界面" VC:[ModelViewController class]];
    [self addTableCellWithTitle:@"图文混排" VC:[TextViewController class]];
    [self addTableCellWithTitle:@"底部输入框" VC:[BottomInputViewController class]];
    
    
}

-(void)addTableCellWithTitle:(NSString *)title VC:(Class )vc
{
    [arrData addObject:title];
    [vcArr addObject:vc];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellstr = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    
    cell.textLabel.text = [arrData objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        ModelViewController *mv = [ModelViewController new];
        mv.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //mv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //mv.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        mv.modalPresentationStyle = UIModalPresentationFormSheet;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mv];
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
    else
    {
        [self.navigationController pushViewController:[[vcArr objectAtIndex:indexPath.row] new] animated:YES];
    }
    
    
    
    
}

@end

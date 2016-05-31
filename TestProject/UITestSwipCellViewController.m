//
//  UITestSwipCellViewController.m
//  TestProject
//
//  Created by wxy on 15/11/4.
//  Copyright © 2015年 wxy. All rights reserved.
//

#import "UITestSwipCellViewController.h"
#import "SwipTableViewCell.h"

#define NUM_ARRAY       15

@interface UITestSwipCellViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UITestSwipCellViewController
{
    UITableView *_tableView;
    NSMutableArray  *_array;
    SwipTableViewCell *_cacheCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    _array = [NSMutableArray new];
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SwipTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(NAV_STATUS_H(self), 0, 0, 0));
    }];
    for (int i = 0; i < NUM_ARRAY; i++) {
        
        NSMutableString *str = [NSMutableString new];
        
        for (int j = 0; j < i; j ++) {
            [str appendString:@"zhi是策划似乎更ig  "];
        }
        
        [_array addObject:str];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [_array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cacheCell == nil) {
        _cacheCell = [[SwipTableViewCell alloc] init];
    }
    _cacheCell.label.text = [_array objectAtIndex:indexPath.row];
    
    [_cacheCell setNeedsLayout];
    [_cacheCell layoutIfNeeded];
    
    CGSize size = [_cacheCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [Utils NSLogWrite:[NSValue valueWithCGSize:size] Str:@"ttttt"];
    return size.height+1;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.label setText:[_array objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *title = _array[sourceIndexPath.row];
    
    [_array removeObject:title];
    [_array insertObject:title atIndex:destinationIndexPath.row];
    
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRow = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       
        [_array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    
    UITableViewRowAction *top = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    
        [_array exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:index];
        [tableView reloadData];
    }];
    
    top.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
    }];
    
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    return @[deleteRow,top,moreRowAction];
    
    
}

@end

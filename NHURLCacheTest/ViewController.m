//
//  ViewController.m
//  NHURLCacheTest
//
//  Created by hu jiaju on 15-7-21.
//  Copyright (c) 2015年 Nanhu. All rights reserved.
//

#import "ViewController.h"

#import "NHDetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray * sourceData;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Test VCR";
    _sourceData = [NSMutableArray arrayWithObjects:
                   @"https://www.baidu.com",
                   @"https://exmail.qq.com",
                   @"http://sina.com",
                   @"https://163.com",
                   @"http://365xs.cn",
                   @"http://igooma.com",nil];
    CGRect bounds = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"cellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIView *destView = cell.contentView;
    [destView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [destView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44.f)];
    label.text = [_sourceData objectAtIndex:indexPath.row];
    label.font = [UIFont systemFontOfSize:15];
    [destView addSubview:label];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [_sourceData objectAtIndex:indexPath.row];
    NHDetailViewController *detailVcr = [[NHDetailViewController alloc] initWithTitle:url withRequestURL:url];
    [self.navigationController pushViewController:detailVcr animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  XBStatisticsViewController.m
//  VideoFetch
//
//  Created by luodezhao on 16/4/10.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "XBStatisticsViewController.h"
#import "XBVideoAdvertSDK/XBAdManager.h"
#import "XBADmsgCell.h"
#import "XBWebViewController.h"
@interface XBStatisticsViewController ()
{
    NSArray *dataArray;
    XBADmsgCell *reuseCell;
}
@property(nonatomic, strong)NSDictionary *list;
@property(nonatomic, strong)NSArray *ary;
@end

@implementation XBStatisticsViewController
-(NSDictionary *)list{
    if (!_list) {
        _list = [[NSDictionary alloc]init];
    }
    return _list;
}
-(NSArray *)ary{
    if (!_ary) {
        _ary = [[NSArray alloc]init];
    }
    return _ary;
}

- (instancetype)initWithStyle:(UITableViewStyle)style andData:(NSArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        dataArray = data;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计数据";
    [self setNav];
    reuseCell = [[[NSBundle mainBundle]loadNibNamed:@"XBADmsgCell" owner:nil options:nil] objectAtIndex:0];

    [self.tableView registerNib:[UINib nibWithNibName:@"XBADmsgCell" bundle:nil] forCellReuseIdentifier:@"XBADmsgCell"];
    [self.tableView reloadData];

  }
- (void)setNav {
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
}
- (void )goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.ary.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XBADmsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XBADmsgCell"];
    cell.data = self.ary[indexPath.section];
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.ary[indexPath.section];
    XBWebViewController *next = [[XBWebViewController alloc]initWithUrl:[dic objectForKey:@"link"]];
    [self.navigationController pushViewController:next animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    reuseCell.data = self.ary[indexPath.section];
    return reuseCell.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}


@end

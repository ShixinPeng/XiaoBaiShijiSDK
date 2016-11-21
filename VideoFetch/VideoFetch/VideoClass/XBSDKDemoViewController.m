//
//  XBSDKDemo.m
//  VideoFetch
//
//  Created by luodezhao on 16/4/7.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "XBSDKDemoViewController.h"
#import <XBVideoAdvertSDK/XBVideoAdvertSDK.h>
#import "XBVideoViewController.h"
#import "XBStatisticsViewController.h"
@interface XBSDKDemoViewController ()

{
    NSArray *arrayData;
}
@end

@implementation XBSDKDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    //王牌1633088
    //嫁个老公过日子：830227
    NSMutableDictionary * a = [[NSMutableDictionary alloc]init];
    [a setObject:@"王牌对王牌" forKey:@"name"];
    [a setObject:@"830227" forKey:@"programId"];
    [a setObject:@"http://api.xiaobaishiji.com/xiaobai-video/video/wpdwp.mp4" forKey:@"urlStr"];
    [a setObject:@"5" forKey:@"showTime"];
    NSMutableDictionary * b = [[NSMutableDictionary alloc]init];
    [b setObject:@"马苏演的" forKey:@"name"];
    [b setObject:@"7176921" forKey:@"programId"];
    [b setObject:@"http://video.xiaobaishiji.com/video/pcsan11/mams/vod/201602/19/11/2016021911515065357df982c_12ef7987.mp4" forKey:@"urlStr"];
    [b setObject:@"190" forKey:@"showTime"];
    arrayData = @[a,b];
    //获取广告列表
   
//    [XBAdManager shareAdManager]requestAdvertListWithProgramId:6540163 withsuccessBlock:<#^(id status)successBlock#> withfailBlock:<#^(NSError *error)failBlock#>



}
- (void)setNav {
    self.title = @"小白世纪";

    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.63 green:0.01 blue:0.07 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClicked)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)rightBtnClicked {
    
    NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[@"测试信息"] forKeys:@[@"name" ]];
    NSArray * a = [NSArray arrayWithObject:dic];
    XBStatisticsViewController * next = [[XBStatisticsViewController alloc]initWithStyle:UITableViewStyleGrouped andData:a];
    
    [self.navigationController pushViewController: next animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoCell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"demoCell"];
         
    }
    cell.textLabel.text = [arrayData[indexPath.row] objectForKey:@"name"];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBVideoViewController *next = [[XBVideoViewController alloc]init];
    next.videoMessage = arrayData[indexPath.row];
    [self.navigationController pushViewController:next animated:YES];
}




@end

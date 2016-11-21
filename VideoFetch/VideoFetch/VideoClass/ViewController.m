//
//  ViewController.m
//  VideoFetch
//
//  Created by shixinPeng on 16/4/5.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "ViewController.h"
#import "XBdownImageHelper.h"
#import "XBnetWorkHelper.h"
#import "XBAdManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
//    测试广告列表
//    [[XBAdManager shareAdManager]requestAdvertListWithProgramId:6540163 withsuccessBlock:^(id status) {
//        
//    } withfailBlock:^(NSError *error) {
//        
//    }];
//    //测试发送广告展示统计
//    [[XBAdManager shareAdManager] requestAdvertShowCountWithAdvertId:@"1608,1609,1610,1611,1612" andImei:nil andType: 0 withsuccessBlock:^(id status) {
//        
//    } withfailBlock:^(NSError *error) {
//        
//    }];
//    //测试广告点击统计接口
//    [[XBAdManager shareAdManager] requestAdvertTrafficCountWithAdvertId:1608 andImei:nil withsuccessBlock:^(id status) {
//        
//    } withfailBlock:^(NSError *error) {
//        
//    }];
    //播放统计接口调试
    [[XBAdManager shareAdManager] requestVideoPlayCounttWithProgramId:6540163 andVideoId:1437167 andImei:nil withsuccessBlock:^(id status) {
        
    } withfailBlock:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

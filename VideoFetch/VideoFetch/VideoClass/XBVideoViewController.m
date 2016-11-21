//
//  XBVideoViewController.m
//  VideoFetch
//
//  Created by luodezhao on 16/4/7.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "XBVideoViewController.h"
#import "XBVideoPlayer.h"
#import <XBVideoAdvertSDK/XBVideoAdvertSDK.h>
#import "XBWebViewController.h"
@interface XBVideoViewController ()<XBVideoPlayerDelegate>
{
    
    XBVideoPlayer* player;
    BOOL isCli;
}
@end

@implementation XBVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    player = [[XBVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    player.showTime = [[self.videoMessage objectForKey:@"showTime"]floatValue];
    player.delegate = self;
    player.urlStr = [self.videoMessage objectForKey:@"urlStr"];
    __weak typeof(self) weakSelf = self;
    [player addToView:self.view andBackBlock:^{
        [weakSelf goBack];
    }];
    [player switchBtnClick];
    [player play];
    [player gotoBig];
    
#pragma mark :--初始化广告页面
    
//    //拿广告数据
   
//[[self.videoMessage objectForKey:@"programId"] integerValue]
   
    [XBAdvertManger initAdvertId:819267  withResult:^(id status) {
        NSLog(@"%@",status);
    } withPlayPause:^(BOOL isPlayPause) {
        NSLog(@"test =isPlayPause %zd ",isPlayPause);
        if (isPlayPause) {
            [player pause];
            
        }else{
            [player play];
        }
    } withAdShow:^{
        NSLog(@"test = withAdShow");
    } withAdClick:^(XBADCLICK_SITE clickSite) {
        NSLog(@"test = clickSite %zd",clickSite);
    }];
    //添加动画图层
    UIView *anView =  [XBAdvertManger getAdvertShowView];

    [player addSubview:anView];

   

}

- (void)presentAdWebViewWithUrlString:(NSString *)urlString {
    XBWebViewController * next = [[XBWebViewController alloc]initWithUrl:urlString andBack:^{
    
        isCli = NO;
            [player gotoBig];
        [player play];
       
    }];
    isCli = YES;
    [player gotoSmall];
    [player pause];
    [self.navigationController pushViewController:next animated:YES];
    
    
}
- (void)buyViewClikeToStopVideo {
    [player pause
     ];
}

- (void)failToPlay {
    [self goBack];
}
- (void)adHiddenToPlayVideo {
    if (!isCli) {
        [player play];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

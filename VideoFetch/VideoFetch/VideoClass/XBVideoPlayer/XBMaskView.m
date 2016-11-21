//
//  LDZMaskView.m
//  MYVideoPlayer
//
//  Created by luodezhao on 16/4/6.
//  Copyright © 2016年 luodezhao. All rights reserved.
//

#import "XBMaskView.h"
#define FootH 40

@implementation XBMaskView
{
    NSString *urlStr;
    
    UIView *footerView;
    UIView *headerView;
    UIButton *playBtn;
    UIButton *switchBtn;
    UIButton *backBtn;
    UILabel *timeLabel;
    
    BOOL isGragSlider;
    BOOL isShowFoot;
    
    BOOL isPlay;
    
    BOOL isBtnStop;
    
    
    UIActivityIndicatorView *activityView;
    
    
    
}

#pragma mark -- 添加一个子控制在view上
- (void)addMaskInView:(UIView *)view {
    
    
    [self createFootView];
    [self createHeaderView];
    [view addSubview:self];
    [self addGesture];
    
}

#pragma maek -- 添加单击手势
- (void)addGesture {
    /** 点击触发后，给后面的那个方法添加手势监听 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelf)];
    /** UIview接受并响应用户的交互 */
    self.userInteractionEnabled = YES;
    /** 手势识别器 */
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapFoot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test)];
    footerView.userInteractionEnabled = YES;
    [footerView addGestureRecognizer:tapFoot];
}
- (void)test {
    NSLog(@"1");
}


#pragma mark -- 点击事件触发后的方法
- (void)hideSelf {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark -- 创建一个view的头
- (void)createHeaderView {
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [self addSubview:headerView];
    
    backBtn=[[UIButton alloc] initWithFrame:CGRectMake(5,0,30,30)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"XBBack"] forState:UIControlStateNormal];
    [headerView addSubview:backBtn];
    headerView.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.5];


}
- (void)backBtnClick {
    /** 判断是否全屏 */
    if (!self.isFullScreen) {
        self.xbPlayer.backBlock();
        [self.xbPlayer close];
        
    }else {
        [self switchBtnClicked];
        self.xbPlayer.backBlock();
        [self.xbPlayer close];
    }
    
}

#pragma mark -- 创建view的尾
- (void)createFootView {
    //底部容器视图
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - FootH, self.frame.size.width, FootH)];
    [self addSubview:footerView];
    footerView.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.5];
    //    footerView.alpha=0.5;
    footerView.userInteractionEnabled=YES;
    
    //播放／暂停按钮
    playBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, FootH /2 - 15 , 30, 30)];
    [playBtn setImage:[UIImage imageNamed:@"XBPlay"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:playBtn];
    
    
    // 切换全屏按钮
    switchBtn = [[UIButton alloc]initWithFrame:CGRectMake(footerView.frame.size.width - 35 ,FootH/2 - 15, 30, 30)];
//    [switchBtn addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [switchBtn setImage:[UIImage imageNamed:@"XBZoomIn"] forState:UIControlStateNormal];
    [footerView addSubview:switchBtn];
    
    
    // 时间
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(switchBtn.frame.origin.x - 80, FootH/2 - 15, 80, 30)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = @"00:00/00:00";
    timeLabel.font=[UIFont systemFontOfSize:10];
    timeLabel.numberOfLines=0;
    timeLabel.textColor=[UIColor whiteColor];
    [footerView addSubview:timeLabel];
    
    //缓冲进度条
    self.bufferProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.bufferProgressView.frame = CGRectMake(playBtn.frame.size.width + 5, FootH/2 -1, timeLabel.frame.origin.x - playBtn.frame.size.width - 10, 2);
    self.bufferProgressView.progressTintColor = [UIColor lightGrayColor];
    self.bufferProgressView.trackTintColor = [UIColor darkGrayColor];
    [footerView addSubview:self.bufferProgressView];
    
    //播放进度条
    self.sliderTime =[[UISlider alloc] initWithFrame:CGRectMake(self.bufferProgressView.frame.origin.x-2,self.bufferProgressView.frame.origin.y-14,self.bufferProgressView.bounds.size.width+2,30)];
    
    [self.sliderTime setThumbImage:[UIImage imageNamed:@"XBSlider"] forState:UIControlStateNormal];
    
    self.sliderTime.minimumTrackTintColor=[UIColor whiteColor];
    self.sliderTime.maximumTrackTintColor=[UIColor clearColor];
    
    [self.sliderTime addTarget:self action:@selector(sliderChange) forControlEvents:UIControlEventValueChanged];
    
    [self.sliderTime addTarget:self action:@selector(sliderChangeEnd) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:self.sliderTime];
    
    [self addLoadingView];
 
    
}
- (void)addLoadingView {
    
    //缓冲旋转菊花
    activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,38,38)];
    [activityView stopAnimating];
    activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:activityView];
    
}
#pragma mark -- 开始加载
- (void)loading {
    /** 开始动画 */
    [activityView startAnimating];
    isPlay = YES;
    /** 点击开始 */
    [self playBtnClicked];

}
#pragma mark -- 结束加载
- (void)endLoading
{
    /** 结束动画 */
    [activityView stopAnimating];
     
 }

- (void)layoutSubviews
{
    footerView.frame = CGRectMake(0, self.frame.size.height - FootH, self.frame.size.width, FootH);
    //播放／暂停按钮
    playBtn.frame= CGRectMake(5, FootH /2 - 15 , 30, 30);
    
    // 切换全屏按钮
    switchBtn.frame = CGRectMake(footerView.frame.size.width - 35 ,FootH/2 - 15, 30, 30);
    
    // 时间
    timeLabel.frame = CGRectMake(switchBtn.frame.origin.x - 80, FootH/2 - 15, 80, 30);
   
    
    //缓冲进度条
    self.bufferProgressView.frame = CGRectMake(playBtn.frame.size.width + 5, FootH/2 -1, timeLabel.frame.origin.x - playBtn.frame.size.width - 10, 2);
    
    //播放进度条
    self.sliderTime.frame =CGRectMake(self.bufferProgressView.frame.origin.x-2,self.bufferProgressView.frame.origin.y-14,self.bufferProgressView.bounds.size.width+2,30);
    //header
    
    headerView.frame = CGRectMake(0, 0, self.frame.size.width, 30);

    activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
}
#pragma mark -- 判断当前页面的方向
- (void)switchBtnClicked {
    /** 机器硬件的当前旋转方向   这个你只能取值 不能设置 */
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    /** 程序界面的当前旋转方向   */
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;

    switch (interfaceOrientation) {
            /** 倒立 */
        case UIInterfaceOrientationPortraitUpsideDown:{
            /** 界面方向 */
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
            /** 正立 */
        case UIInterfaceOrientationPortrait:{
            [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
            [self.xbPlayer changeFrameToBig];
            /** 判断是否全屏 */
            self.isFullScreen = YES;
        }
            break;
            /** 向右 */
        case UIInterfaceOrientationLandscapeLeft:{
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
            [self.xbPlayer changeFrameToSmall];
            self.isFullScreen = NO;
        }
            break;
            /** 向右 */
        case UIInterfaceOrientationLandscapeRight:{
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
            [self.xbPlayer changeFrameToSmall];
            self.isFullScreen = NO;
        }
            break;
        default:
            [self interfaceOrientation:UIInterfaceOrientationPortrait];
            [self.xbPlayer changeFrameToSmall];
            self.isFullScreen = NO;

            break;
    }

}
- (void)gotoBig {
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    [self.xbPlayer changeFrameToBig];
    /** 判断是否全屏 */
    self.isFullScreen = YES;
}
- (void)gotoSmall {
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [self.xbPlayer changeFrameToSmall];
    self.isFullScreen = NO;
}
#pragma mark -- 屏幕当前旋转定位
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        /** 消息调用 */
        [invocation invoke];
        
    }
}
#pragma mark -- 判断是否点击播放
- (void)playBtnClicked {
    if (isPlay) {
        
        [self changeBtnStatePlay:YES];
        [self.xbPlayer pause];
        isPlay = NO;
    }else {
        
        [self changeBtnStatePlay:NO];
        [self.xbPlayer play];
        [activityView stopAnimating];
        isPlay = YES;
    }
    
}

- (void)changeBtnStatePlay:(BOOL)tag {
    if (tag) {
        isPlay = NO;
        [playBtn setImage:[UIImage imageNamed:@"XBPlay"] forState:UIControlStateNormal];
    }else {
        isPlay = YES;
        [playBtn setImage:[UIImage imageNamed:@"XBPause"] forState:UIControlStateNormal];
    }

}
- (void)sliderChange {
    if (self.totalTime == 0) {
        return;
    }
    isGragSlider = YES;
    
    [self.xbPlayer gotoTime:self.sliderTime.value * self.totalTime ];
    
}
- (void)sliderChangeEnd {
    isGragSlider = NO;
}

#pragma mark -- 时间更新 当前时间/总时间
- (void)updataCurrentTime:(CGFloat)currentTime andTotalTime:(CGFloat)totalTime {
    self.totalTime = totalTime;
    int a = currentTime/60;//分钟
    int b = totalTime/60;//总的分钟
    int c = currentTime - a*60;
    int d = totalTime - b*60;
    
    /** 设置时间label的显示 */
    timeLabel.text=[NSString stringWithFormat:@"%d:%02d/%d:%02d",a,c,b,d];
    if (!isGragSlider) {
        /** 设置sliderTime的值 */
        self.sliderTime.value = currentTime/totalTime;

    }
}
#pragma mark -- 判断是否是全屏，如果是切换到按钮图片
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        [switchBtn setImage:[UIImage imageNamed:@"XBZoomOut"] forState:UIControlStateNormal];
    }else
    {
        [switchBtn setImage:[UIImage imageNamed:@"XBZoomIn"] forState:UIControlStateNormal];

    }
}

@end

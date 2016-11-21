//
//  LDZPlayer.m
//  MYVideoPlayer
//
//  Created by luodezhao on 16/4/6.
//  Copyright © 2016年 luodezhao. All rights reserved.
//

#import "XBVideoPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "XBMaskView.h"
#import <XBVideoAdvertSDK/XBVideoAdvertSDK.h>
@implementation XBVideoPlayer
{
    AVPlayerLayer *playerLayer;//播放器layer
    // 总时间
    CGFloat totalTime;
    
    BOOL isPlay;
    // 播放器框架
    CGRect playerFrame;
    // 主要视图框架
    CGRect mainViewFrame;
    
    id  playerTimeObserver;
    void (^backB)();
}
#pragma mark -- 改变frame横屏的大小
- (void)changeFrameToBig {
    self.frame = CGRectMake(0, 0, mainViewFrame.size.height, mainViewFrame.size.width);
    playerLayer.frame = self.bounds;
    self.maskView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}
#pragma maek -- 改变frame竖屏的大小
- (void)changeFrameToSmall {
    
    self.frame = playerFrame;
    playerLayer.frame = self.bounds;
    self.maskView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        playerFrame = frame;
    }
    return self;
}
#pragma mark -- 添加手势
- (void)addPanGesture {
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMaskView)];
    /** 启动用户交互 */
    self.userInteractionEnabled = YES;
    /** 添加手势识别器 */
    [self addGestureRecognizer:tag];
}

- (void)showMaskView {
    [self addSubview:self.maskView];
    self.maskView.alpha = 0;
    /** 动画持续的时间 */
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1;
    }];
}

- (void)createUI {
    self.backgroundColor = [UIColor blackColor];
    [self createPlayer];
    [self setObserver];
    [self createMaskView];
    
    [self addPanGesture];

}
#pragma mark -- 创建Mark的视图
- (void)createMaskView {
    self.maskView = [[XBMaskView alloc]initWithFrame:self.bounds];
    self.maskView.xbPlayer = self;
    [self.maskView addMaskInView:self];
}


- (void)addToView:(UIView *)view andBackBlock:(void (^)())myBlock{
    [self createUI];
    mainViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    self.backBlock = myBlock;
    [view addSubview:self];

}
/**
 *  根据视频索引取得AVplayerItem对象
 */
- (void)createPlayer {
       /** 把地址加到播放器中 */
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.urlStr]];
    /** 监听player的地址 */
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.bounds;
    [self.layer addSublayer:playerLayer];

    __weak typeof(self) weakSelf = self;
    /** 这里设置每秒执行一次 */
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        CGFloat current = CMTimeGetSeconds(weakSelf.player.currentItem.currentTime);

#pragma mark :--监听到播放进度，
      [XBAdvertManger postVideoCurrentPlayTime:current];
      
        if (current) {
            totalTime = total;
            [weakSelf.maskView updataCurrentTime:current andTotalTime:total];
        }
    }];
    

}


- (void)play {
    [self.player play];
    [self.maskView changeBtnStatePlay:NO];
    
    
}
- (void)pause
{
    [self.player pause];
    [self.maskView changeBtnStatePlay:YES];
}
- (void)gotoSmall {
    
[self.maskView gotoSmall
 ];
}
-(void)gotoBig {
    [self.maskView gotoBig];
}
- (void)setObserver {
    AVPlayerItem *playerItem = self.player.currentItem;
    /** 监控状态属性，注意AVplayer也有一个status属性，通过监听它的status也可以获取播放状态 */
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    /** 监控网络加载情况属性*/
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    /** 监听playbackLikelyToKeepUp属性 */
    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    /** 监听playbackBufferEmpty属性*/
    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    

    
    //添加AVPlayerItem播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    //添加AVPlayerItem开始缓冲通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bufferStart) name:AVPlayerItemPlaybackStalledNotification object:playerItem];
    //进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:UIApplicationWillResignActiveNotification object:nil];
     // 返回前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PP) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
}
- (void)PP {
    [self play];
    [self switchBtnClick];
}
#pragma mark -- 转到时间

- (void)gotoTime:(CGFloat)time {
    /** 当前的时间和每秒钟多少帧 */
    [self.player seekToTime:CMTimeMakeWithSeconds(time, 1) completionHandler:^(BOOL finished) {
    }];

}
- (void)bufferStart {
    
}
#pragma mark -- 删除当前观察者添加新的路径
- (void)removeObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.player.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
//KVO监控回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        [self.maskView endLoading];
    }
    if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        [self.maskView loading];
    }
    //监控网络加载情况属性
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        CGFloat startTime = CMTimeGetSeconds(timeRange.start);
        CGFloat endTime = CMTimeGetSeconds(timeRange.duration);
        
        /** 总缓冲 = 开始的时间+结束时间 */
        CGFloat totalBuffer = startTime + endTime;
        if (totalTime) {
            /** 视图缓冲区进展 */
            [self.maskView.bufferProgressView setProgress:totalBuffer/totalTime animated:YES];

        }
        
    }
    //监控状态属性
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        switch (status) {
                case AVPlayerStatusReadyToPlay:
            {
                CGFloat current = CMTimeGetSeconds(self.player.currentItem.currentTime);
                if (current  < self.showTime) {
                    [self gotoTime:self.showTime];
                }
                                [self.maskView endLoading];
            }
                break;
            case AVPlayerStatusUnknown:
            {
                [self.maskView loadingView];
            }
                break;
            case AVPlayerStatusFailed:
            {
                [self close];
                [self.maskView switchBtnClicked];
                if (self.delegate && [self.delegate respondsToSelector:@selector(failToPlay)]) {
                    [self.delegate failToPlay];
                }
                NSLog(@"播放失败");
            }
                break;
            default:
                break;
        }

    }
}
- (void)close {
    [self removeObserver];
    // 取消等待寻求
    [self.player.currentItem cancelPendingSeeks];
    // 取消加载
    [self.player.currentItem.asset cancelLoading];
    [self.player removeTimeObserver:playerTimeObserver];
    playerTimeObserver = nil;
    
    [self.player cancelPendingPrerolls];
    
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [_maskView removeFromSuperview];
    
    [playerLayer removeFromSuperlayer];
}

#pragma mark -- 判断是否是全屏
- (void)setIsFullScreen:(BOOL)isFullScreen {
    self.maskView.isFullScreen = isFullScreen;
}

- (void)orientChange:(NSNotification *)noti
{
    UIDeviceOrientation  orient = [UIDevice currentDevice].orientation;
    /*
     UIDeviceOrientationUnknown,
     UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
     UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
     UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
     UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
     UIDeviceOrientationFaceUp,              // Device oriented flat, face up
     UIDeviceOrientationFaceDown             // Device oriented flat, face down   */
    
    switch (orient)
    {
        case UIDeviceOrientationPortrait:
            [self changeFrameToSmall];
            self.isFullScreen = NO;
            break;
        case UIDeviceOrientationLandscapeLeft:
            
            [self changeFrameToBig];
            self.isFullScreen = YES;
            
            
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self changeFrameToBig];
            self.isFullScreen = YES;
            
            
            break;
        case UIDeviceOrientationLandscapeRight:
            
            [self changeFrameToBig];
            self.isFullScreen = YES;
            
            break;
            
        case UIDeviceOrientationFaceUp:
            break;
            
            
        default:
            [self changeFrameToSmall];
            break;
    }
}
- (void)switchBtnClick {
    [self.maskView switchBtnClicked];
}

@end

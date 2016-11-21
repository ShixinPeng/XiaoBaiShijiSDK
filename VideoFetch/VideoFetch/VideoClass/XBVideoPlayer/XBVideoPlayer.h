//
//  LDZPlayer.h
//  MYVideoPlayer
//
//  Created by luodezhao on 16/4/6.
//  Copyright © 2016年 luodezhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVPlayer;
@class XBMaskView;
@protocol XBVideoPlayerDelegate <NSObject>

- (void)failToPlay;

@end
@interface XBVideoPlayer : UIView
@property (nonatomic,strong)  AVPlayer *player;

/** 滑动时间 */
@property (nonatomic,strong) UISlider *sliderTime;
/** 隐藏view */
@property (nonatomic,strong) XBMaskView *maskView;

@property (nonatomic,assign) BOOL isFullScreen;

@property (nonatomic,strong) void (^backBlock)();

@property (nonatomic,strong) NSString *urlStr;

@property (nonatomic,assign) CGFloat showTime;

@property (nonatomic,strong) id <XBVideoPlayerDelegate> delegate;
- (void)addToView:( UIView *)view andBackBlock:( void  (^)())myBlock;
//播放
- (void)play;
//暂停
- (void)pause;
//关闭播放器并且销毁当前view
- (void)close;
- (void)gotoTime:(CGFloat)time;
- (void)changeFrameToBig;
- (void)changeFrameToSmall;
- (void)switchBtnClick;
- (void)gotoBig;
- (void)gotoSmall;
@end

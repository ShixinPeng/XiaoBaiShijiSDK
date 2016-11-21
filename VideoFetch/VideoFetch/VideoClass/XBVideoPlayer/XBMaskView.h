//
//  LDZMaskView.h
//  MYVideoPlayer
//
//  Created by luodezhao on 16/4/6.
//  Copyright © 2016年 luodezhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBVideoPlayer.h"
@interface XBMaskView : UIView
/** 滑动时间 */
@property (nonatomic,strong) UISlider *sliderTime;
/**  */
@property (nonatomic,weak) XBVideoPlayer *xbPlayer;
/** 总时间 */
@property (nonatomic,assign) CGFloat totalTime;
/** 缓冲进度 */
@property (nonatomic,strong) UIProgressView *bufferProgressView;
/** 加载视图 */
@property (nonatomic,strong) UIView *loadingView;
/** 判断窗口是否全屏 */
@property (nonatomic,assign) BOOL isFullScreen;

/**
 *  添加一个控制器在view上
 */
- (void)addMaskInView:(UIView *)view;
/**
 *  时间更新
 *
 *  @param currentTime 当前时间
 *  @param totalTime   总时间
 */
- (void)updataCurrentTime:(CGFloat)currentTime andTotalTime:(CGFloat)totalTime ;
/**
 *  开始加载
 */
- (void)loading;
/**
 *  结束加载
 */
- (void)endLoading;
- (void)switchBtnClicked;
- (void)changeBtnStatePlay:(BOOL)tag ;
- (void)gotoBig;
- (void)gotoSmall;
@end

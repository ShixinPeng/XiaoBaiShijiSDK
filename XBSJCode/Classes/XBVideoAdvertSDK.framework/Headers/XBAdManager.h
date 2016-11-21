//
//  XBAdManager.h
//  Version: 2.0(1)
//
//  Copyright © 2016年 Xbentury. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    XBAD_PAUSE_ONBUYVIEW,      //点击标签则调用暂停播放的接口
    XBAD_PAUSE_ONWEBVIEW,      //在即将进入webView购买的时候调用暂停接口

} XBPAUSEVIDEO_SITE;

typedef enum : NSUInteger{
    XBAD_CLICK_LOG,            //点击log图标
    XBAD_CLICK_DETAILVIEW,     //点击详情图标
    
}XBADCLICK_SITE;

@class XBAdStates;
#define XBAdvertManger [XBAdManager shareAdManager]

/**
 *  网络请求的回调
 */
typedef void(^resultBlock)(id status);

  /** 控制播放的回调  */
typedef void(^playStautsBlock)(BOOL isPlayPause);
  /** 统计展示的block  */
typedef void(^onADShow)();
  /** 统计点击广告的block  */
typedef void(^onADClick)(XBADCLICK_SITE clickSite);


@interface XBAdManager : NSObject
//==============广告参数的设置======================
/**
 *  是否暂停播放的时候添加遮罩，默认为:false
 */
@property(nonatomic,assign)BOOL isHasEffect;
/**
 *  暂停的位置,默认为:XBAD_PAUSEVIDEO_ONBUYVIEW
 *  点击标签则调用暂停播放的接口
 *  XBAD_PAUSE_ONBUYVIEW,
 *  在即将进入webView购买的时候调用暂停接口
 *  XBAD_PAUSE_ONWEBVIEW,
 */
@property(nonatomic,assign)XBPAUSEVIDEO_SITE pauseSite;
/**
 *  是否为全屏播放，默认为:YES
 */
@property(nonatomic,assign)BOOL isFull;
/**
 *  接口测试参数，默认为:NO<请勿修改>
 *
 */
@property(nonatomic,assign)BOOL isTest;

//==============关于注册信息接口===================
/**
 *  获取SDK管理对象>可以接使用 “XBAdvertManger”
 *
 *  使用这个单例进行网络认证、数据存储、和动画的提供
 */
+(instancetype)shareAdManager;
/**
 *  首要任务：获取小白世纪认证 要在appDelegate中首先实现该方法
 *
 *  @param appKey         企业的获取的appKey
 *  @param appPackageName 企业app的项目名-》填nil则根据BoundId自动生成一个账号
 */
-(void)registerWithAppKey:(NSString *)appKey
        andAppPackageName:(NSString *)appPackageName;

/**
 *  获取对应视频的广告
 *
 *  @param programId    视频ID
 *  @param resultBlock 成功为nil
 *  @stopPlayBlock 通过block回调来播放或者暂停播放
 *  @showStatis 广告开始展示的回调
 *  @adClickStatis 点击广告的回调
 */
- (void)initAdvertId:(NSInteger)programId
          withResult:(resultBlock)resultBlock
       withPlayPause:(playStautsBlock)playPauseBlock
          withAdShow:(onADShow)adShowBlock
         withAdClick:(onADClick)adClickBlock;

//===============关于广告播放的接口===========
/**
 *  监听接口  获取当前视频播放的进度
 *
 *  @param currentPlayTime 当前播放的进度
 */
-(void)postVideoCurrentPlayTime:(NSInteger)currentPlayTime;
/**
 *  获取广告交互页
 *  全屏尺寸
 *  @return 广告交互层，添加到视频播放界面
 */
-(UIView *)getAdvertShowView;

@end

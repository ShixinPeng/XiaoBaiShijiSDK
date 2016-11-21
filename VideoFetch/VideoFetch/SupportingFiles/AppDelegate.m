//
//  AppDelegate.m
//  VideoFetch
//
//  Created by shixinPeng on 16/4/5.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XBSDKDemoViewController.h"
#import <XBVideoAdvertSDK/XBVideoAdvertSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor: [UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    XBSDKDemoViewController *mainController = [[XBSDKDemoViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:mainController];
    [self.window setRootViewController:nav];
//    //华数注册
//    [XBAdvertManger registerWithAppKey:@"1fc7b906313e297a63fac7fbae7ad4bee280b145" andAppPackageName:@"com.tvfan"];
    //风行注册
    [XBAdvertManger registerWithAppKey:@"cb89b4b75f85824636ed6d2c5f77fb9ed017c17e" andAppPackageName:@"com.funshion.video.mobile"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

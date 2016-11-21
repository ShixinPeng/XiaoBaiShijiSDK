//
//  XBWebViewController.h
//  VideoFetch
//
//  Created by luodezhao on 16/4/12.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBWebViewController : UIViewController
- (instancetype)initWithUrl:(NSString *)url;
- (instancetype)initWithUrl:(NSString *)url andBack:(void (^)())back;
@end

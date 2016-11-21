//
//  XBWebViewController.m
//  VideoFetch
//
//  Created by luodezhao on 16/4/12.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "XBWebViewController.h"

@interface XBWebViewController ()
{
    NSString *webUrl;
    void (^go)();
}
@end

@implementation XBWebViewController
- (instancetype)initWithUrl:(NSString *)url andBack:(void (^)())back {
    self = [self initWithUrl:url];
    if (self) {
        go = back;
    }
    return self;
}
- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        webUrl = url;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
                                        [self.view addSubview:web];
    [self.view addSubview:web];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
    
                                            
    // Do any additional setup after loading the view.
}
- (void)setNav {
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
}
- (void )goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    if (go) {
        go();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

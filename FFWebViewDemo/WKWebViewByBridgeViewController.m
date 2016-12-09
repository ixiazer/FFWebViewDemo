//
//  WKWebViewByBridgeViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "WKWebViewByBridgeViewController.h"
#import "NSString+FF.h"
#import "WKWebViewJavascriptBridge.h"

#define FFJSAndNativeBridgeAccept @"ffbridgesend" // app接收js指令，对应的h5发送指令
#define FFJsAndNativeBridgeSend @"ffbridgeaccept" // app发送js指令，对应的h5接受指令

@interface WKWebViewByBridgeViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebViewJavascriptBridge *webBridge;
@end

@implementation WKWebViewByBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView 和 js 交互 by bridge";
    
    // 本地模拟测试
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webview loadHTMLString:appHtml baseURL:baseURL];
    
    self.webBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webview];
    [self.webBridge setWebViewDelegate:self];
    [self webBridgeAccept];
    
    [self.view addSubview:self.webview];
    
    [self webBrightSend:[NSString jsonStringWithDictionary:@{@"method":@"deviceinfo",@"device":@"ios",@"version":@"3.3"}]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width-44, 100, 44, 44);
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(shareSuc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark -- method
#pragma mark - webBridge method
// 接受H5 js方法
- (void)webBridgeAccept {
    __weak typeof(self) this = self;
    [self.webBridge registerHandler:FFJSAndNativeBridgeAccept handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"h5event---->>%@", data);
        [this h5EventAnalysis:data];
        responseCallback(nil);
    }];
}

// 给h5传递数据
- (void)webBrightSend:(id)params {
    [self.webBridge callHandler:FFJsAndNativeBridgeSend data:params responseCallback:^(id responseData) {
        NSLog(@"调用完JS后的回调：%@",responseData);
    }];
}

- (void)h5EventAnalysis:(id)data {
    NSLog(@"H5 事件=====>>%@",data);
    FFShowAlertView([NSString jsonStringWithDictionary:data]);
}

- (void)shareSuc:(id)sender {
    [self webBrightSend:[NSString jsonStringWithDictionary:@{@"method":@"sharesuc",@"sharemethod":@"linkbywechatfriend"}]];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    FFShowAlertView(message);
    
    completionHandler();
    NSLog(@"message===>>%@", message);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

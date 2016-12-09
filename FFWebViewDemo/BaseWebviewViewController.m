//
//  BaseWebviewViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "BaseWebviewViewController.h"
#import "NSString+FF.h"

#define FFJSAndNativeBridgeAccept @"ffbridgesend" // app接收js指令，对应的h5发送指令
#define FFJsAndNativeBridgeSend @"ffbridgeaccept" // app发送js指令，对应的h5接受指令


@interface BaseWebviewViewController ()
@end

@implementation BaseWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView";
}

- (void)loadWebUrl:(NSString *)webUrl {
    NSURL *url = [NSURL URLWithString:webUrl];
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:requestUrl];
    [self.view addSubview:self.webview];
}

#pragma mark -- method
#pragma mark - webBridge method
// 接受H5 js方法
- (void)webBridgeAccept {
    __weak typeof(self) this = self;
    [self.webBridge registerHandler:FFJSAndNativeBridgeAccept handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"h5event---->>%@", data);
        [this h5EventAnalysis:data];
    }];
}

// 给h5传递数据
- (void)webBrightSend:(id)params {
    [self.webBridge callHandler:FFJsAndNativeBridgeSend data:params];
}

- (void)h5EventAnalysis:(id)data {
    NSLog(@"H5 事件=====>>%@",data);
    FFShowAlertView([NSString jsonStringWithDictionary:data]);
}


#pragma mark -- get method
- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webview.backgroundColor = [UIColor clearColor];
    }
    
    return _webview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

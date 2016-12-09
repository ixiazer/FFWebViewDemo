//
//  BaseWKWebViewViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "BaseWKWebViewViewController.h"

@interface BaseWKWebViewViewController () 
@end

@implementation BaseWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WKWebView";
}

- (void)loadWebUrl:(NSString *)webUrl {
    NSURL *url = [NSURL URLWithString:webUrl];
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:requestUrl];
    [self.view addSubview:self.webview];
}

#pragma mark -- get method
- (WKWebView *)webview {
    if (!_webview) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//        config.preferences.minimumFontSize = 25;
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webview.UIDelegate = self;
        
        WKUserContentController *userCC = config.userContentController;
        //JS调用OC 添加处理脚本
        [userCC addScriptMessageHandler:self name:@"ffbridgesend"];
    }
    
    return _webview;
}


- (void)dealloc {
    self.webview.UIDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

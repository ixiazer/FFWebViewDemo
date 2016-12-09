//
//  WebviewBridgeViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "WebViewBridgeViewController.h"
#import "NSString+FF.h"

@interface WebViewBridgeViewController ()

@end

@implementation WebViewBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView 和 js 交互";

    // 本地模拟测试
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webview loadHTMLString:appHtml baseURL:baseURL];
    
    self.webBridge = [WebViewJavascriptBridge bridgeForWebView:self.webview];
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

#pragma mark - method
- (void)shareSuc:(id)sender {
    [self webBrightSend:[NSString jsonStringWithDictionary:@{@"method":@"sharesuc",@"sharemethod":@"linkbywechatfriend"}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

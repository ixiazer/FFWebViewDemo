//
//  WKWebViewByNativeViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "WKWebViewByNativeViewController.h"
#import "NSString+FF.h"

@interface WKWebViewByNativeViewController ()

@end

@implementation WKWebViewByNativeViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WKWebView 和 js 交互 native";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index-wkwebview" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webview loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    [self.view addSubview:self.webview];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width-50, 20+64, 44, 44);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if (message.body && [message.body isKindOfClass:[NSDictionary class]]) {
        FFShowAlertView([NSString jsonStringWithDictionary:message.body]);
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    FFShowAlertView(message);
    
    completionHandler();
    NSLog(@"message===>>%@", message);
}

#pragma mark -- method
- (void)click:(id)sender {
    if (!self.webview.loading) {
        NSDictionary *dic = @{@"method":@"sharesuc"};
        NSString *dicStr = [NSString jsonStringWithDictionary:dic];
        NSString *jsStr = [NSString stringWithFormat:@"ffbridgeaccept('%@')",dicStr];
        
        [self.webview evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            //TODO
            NSLog(@"%@ %@",response,error);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

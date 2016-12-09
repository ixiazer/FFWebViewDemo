//
//  ViewController.m
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import "ViewController.h"
#import "BaseWebviewViewController.h"
#import "BaseWKWebViewViewController.h"
#import "WebviewBridgeViewController.h"
#import "WKWebViewByNativeViewController.h"
#import "WKWebViewByBridgeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 100+54*i, self.view.frame.size.width, 44);
        if (i == 0) {
            [btn setTitle:@"UIWebView Test" forState:UIControlStateNormal];
        } else if (i == 1) {
            [btn setTitle:@"WKWebView Test" forState:UIControlStateNormal];
        } else if (i == 2) {
            [btn setTitle:@"UIWebView Native&Js by WebViewJavascriptBridge" forState:UIControlStateNormal];
        } else if (i == 3) {
            [btn setTitle:@"WKWebView Native&Js by native" forState:UIControlStateNormal];
        } else if (i == 4) {
            [btn setTitle:@"WKWebView Native&Js by WebViewJavascriptBridge" forState:UIControlStateNormal];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}


#pragma mark -- method
- (void)click:(UIButton *)sender {
    NSInteger tag = sender.tag;
    
    if (tag == 0) {
        BaseWebviewViewController *wbVC = [[BaseWebviewViewController alloc] init];
        [wbVC loadWebUrl:@"http://www.freshfresh.com/ffweb/shuang12"];
        [self.navigationController pushViewController:wbVC animated:YES];
    } else if (tag == 1) {
        BaseWKWebViewViewController *wkVC = [[BaseWKWebViewViewController alloc] init];
        [wkVC loadWebUrl:@"http://www.freshfresh.com/ffweb/shuang12"];
        [self.navigationController pushViewController:wkVC animated:YES];
    } else if (tag == 2) {
        WebViewBridgeViewController *wkVC = [[WebViewBridgeViewController alloc] init];
        [self.navigationController pushViewController:wkVC animated:YES];
    } else if (tag == 3) {
        WKWebViewByNativeViewController *wkVC = [[WKWebViewByNativeViewController alloc] init];
        [self.navigationController pushViewController:wkVC animated:YES];
    } else if (tag == 4) {
        WKWebViewByBridgeViewController *wkVC = [[WKWebViewByBridgeViewController alloc] init];
        [self.navigationController pushViewController:wkVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

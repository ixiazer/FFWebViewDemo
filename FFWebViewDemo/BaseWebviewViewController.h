//
//  BaseWebviewViewController.h
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

#define FFShowAlertView(_message_)  UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:_message_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];\
[alertView show];


@interface BaseWebviewViewController : UIViewController

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) WebViewJavascriptBridge *webBridge;

- (void)loadWebUrl:(NSString *)webUrl;
- (void)webBridgeAccept;
- (void)webBrightSend:(id)params;

@end

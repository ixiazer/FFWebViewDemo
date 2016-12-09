//
//  BaseWKWebViewViewController.h
//  FFWebViewDemo
//
//  Created by ixiazer on 2016/12/9.
//  Copyright © 2016年 FF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#define FFShowAlertView(_message_)  UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:_message_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];\
[alertView show];


@interface BaseWKWebViewViewController : UIViewController <WKScriptMessageHandler, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webview;
- (void)loadWebUrl:(NSString *)webUrl;
@end

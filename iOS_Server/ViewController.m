//
//  ViewController.m
//  iOS_Server
//
//  Created by Coder on 2019/7/2.
//  Copyright © 2019 Alec. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic)  WKWebView *webView;
@property (nonatomic, copy) NSString *urlStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWebview];
    [self loadLocalHttpServer];
}

- (void)setWebview{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

- (BOOL)loadLocalHttpServer{
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *port = appd.port;
    if (!port) { return NO; }
    
    NSString *str = [NSString stringWithFormat:@"http://localhost:%@", port];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    return YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end

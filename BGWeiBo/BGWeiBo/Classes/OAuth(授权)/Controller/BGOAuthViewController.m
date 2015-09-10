//
//  BGOAuthViewController.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "BGHttpTool.h"
#import "BGAcount.h"
#import "UIWindow+Extension.h"
#import "BGAcountTool.h"

#define BGAppkey @"4039444927"
#define BGAppSecret @"9f0281be444b16ae6c287a633564913a"
#define BGRedirectURI @"http://www.baidu.com"

@interface BGOAuthViewController ()<UIWebViewDelegate>

@end

@implementation BGOAuthViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    const NSString *appKey = BGAppkey;
    const NSString *redirectUri = BGRedirectURI;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",appKey, redirectUri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    //判断是否为回掉地址
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:fromIndex];
        
        //利用code获得accessToken
        [self accessTokenWithCode:code];
        
        //禁止加载回掉地址
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = BGAppkey;
    params[@"client_secret"] = BGAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = BGRedirectURI;
    params[@"code"] = code;
    
    [BGHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        BGAcount *account = [BGAcount accountWithDict:json];
        
        // 存储账号信息
        [BGAcountTool saveAcount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

@end

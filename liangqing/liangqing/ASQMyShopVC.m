//
//  ASQMyShopVC.m
//  Acommunitise
//
//  Created by Macx on 16/9/12.
//  Copyright © 2016年 ttwd6. All rights reserved.
//

#import "ASQMyShopVC.h"
#import <WebKit/WebKit.h>
#import "MJRefresh.h"
#import "configHead.h"
@interface ASQMyShopVC ()<WKNavigationDelegate,UIScrollViewDelegate,WKUIDelegate,WKScriptMessageHandler>//WKScriptMessageHandler  JS与OC交互的协议
@property (nonatomic , strong)WKWebView * Wwebview ;
@property (nonatomic , strong)UIProgressView * progressview;
@property (nonatomic , strong)UIBarButtonItem * closeItem;
@property (nonatomic , strong)UIBarButtonItem * backItem;
@property (nonatomic , copy  )NSString * sessionID;


@end

@implementation ASQMyShopVC
- (WKWebView *)Wwebview
{
    if (!_Wwebview) {
        
        self.Wwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.Wwebview.backgroundColor = [UIColor whiteColor];
        self.Wwebview.UIDelegate          = self;
        self.Wwebview.navigationDelegate  = self;
        _Wwebview.allowsBackForwardNavigationGestures = YES;
        self.automaticallyAdjustsScrollViewInsets = YES;
        [self.Wwebview setMultipleTouchEnabled:YES];
        [self.Wwebview setAutoresizesSubviews:YES];
        [self.Wwebview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return _Wwebview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下面两句解决每次返回都会上移20高度的问题
    self.automaticallyAdjustsScrollViewInsets            = NO;// tabView偏移暂时的解决办法
    self.navigationController.navigationBar.translucent  = NO;// 关闭导航栏透明度，不可关 会推上去补位
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x049b2f5);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWedview];
//    [self createprogressview];
    
    
}
- (void)createprogressview
{
    self.progressview = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width, 5)];
    // 设置进度条的色彩
    self.progressview.progressViewStyle = UIProgressViewStyleDefault;
    [self.progressview setTrackTintColor:[UIColor clearColor]];
    self.progressview.progressTintColor = [UIColor greenColor];
    self.progressview.progress = 0.2;
//    [self.view addSubview:self.progressview];
}

- (void)createBackBtn
{
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem  = nil;
    
    UIButton * closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBlicked:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.contentMode = UIViewContentModeScaleAspectFit;
//    closeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];

    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 54, 44)];
    UIImage* backItemImage = [[UIImage imageNamed:@"backItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage* backItemHlImage = [[UIImage imageNamed:@"backItemImage-hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:backItemImage forState:UIControlStateNormal];
    [backBtn setImage:backItemHlImage forState:UIControlStateHighlighted];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeScaleAspectFit;
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [backBtn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    
    _closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    _backItem  = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
}

- (void)closeBlicked:(UIBarButtonItem *)item
{
    [self.Wwebview goToBackForwardListItem:[self.Wwebview.backForwardList.backList firstObject]];
}

- (void)goback:(UIButton *)btn
{
    if (self.Wwebview.canGoBack) {
        [self.Wwebview goBack];
        [self.Wwebview evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable titlestr, NSError * _Nullable error) {
            
            self.navigationItem.title = titlestr;
        }];
    }
    else
    {
        [self.Wwebview goToBackForwardListItem:[self.Wwebview.backForwardList.backList firstObject]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x049b2f5);
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:19],NSFontAttributeName,nil];
    
}

- (void)createWedview
{
    
    [self.view addSubview:self.Wwebview];
    self.Wwebview.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    
        NSMutableURLRequest *baidurequset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://zhlq.nnwsl.com/index.php?s=/Wap"]];
        NSLog(@"H5url:===%@",self.urlString);
        [baidurequset addValue:[@YES stringValue] forHTTPHeaderField:@"mywork"];
        
        [self.Wwebview loadRequest:baidurequset];
        
        
        
        
        
    }];
    
    if (self.Wwebview) {
        
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        WKPreferences *preferences = [WKPreferences new];
        //创建UserContentController(提供javaScript向webView发送消息的方法)
        WKUserContentController *userContent = [WKUserContentController new];
        Configuration.allowsAirPlayForMediaPlayback  = YES;// 允许视频播放
        Configuration.allowsInlineMediaPlayback      = YES;// 允许在线播放
        Configuration.selectionGranularity           = YES;// 允许可以与网页交互，选择视图
        Configuration.suppressesIncrementalRendering = YES;// 是否支持记忆读取
        Configuration.processPool = [[WKProcessPool alloc] init];// web内容处理池
        
        preferences.javaScriptCanOpenWindowsAutomatically = NO;
        preferences.minimumFontSize = 30.0;
        
        //将UserContentController设置到配置文件中
        Configuration.userContentController = userContent;
        Configuration.preferences = preferences;
        
        
        NSMutableURLRequest *baidurequset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://zhlq.nnwsl.com/index.php?s=/Wap"]];
        NSLog(@"H5url:===%@",self.urlString);
        [baidurequset addValue:[@YES stringValue] forHTTPHeaderField:@"mywork"];

        [self.Wwebview loadRequest:baidurequset];
        //[self.Wwebview loadHTMLString:[self readLocalHtmlString] baseURL:nil];
        [self.Wwebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self.Wwebview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    [self createBackBtn];
    
    self.Wwebview.userInteractionEnabled = YES;
    
}
#pragma mark - WKNavigationDelegate


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    if (self.Wwebview.scrollView.mj_header) {
        
        [self.Wwebview.scrollView.mj_header endRefreshing];
    }
    [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('mui-bar mui-bar-tab')[0].style.display = 'none'" completionHandler:^(id _Nullable lable, NSError * _Nullable error) {
        
    }];
    [webView evaluateJavaScript:@"document.documentElement.getElementsByClassName('mui-bar bar-qr')[0].style.display = 'none'" completionHandler:^(id _Nullable lable, NSError * _Nullable error) {
        
    }];
//    if (webView.isLoading) {
//     
//        return;
//    }
    
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable titlestr, NSError * _Nullable error) {
            
            self.navigationItem.title = titlestr;
        }];
    [self saveHtml];
        
    
   
}


- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
    self.progressview.hidden = NO;
    
}


- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
}
#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//        
        NSString * webURL = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
        
        NSLog(@"URL:%@",webURL);
        if ([webURL containsString:@"tel:"]) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:webURL] options:@{@"tel":@"num"} completionHandler:^(BOOL success) {
                
            }];
            
            decisionHandler(WKNavigationActionPolicyCancel);
        }
        else
        {
            decisionHandler(WKNavigationActionPolicyAllow);
        
        }

    
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self.Wwebview) {
        
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            
            if (self.Wwebview.estimatedProgress == 1.0) {
                
                self.progressview.hidden = YES;
            }else
            {
                self.progressview.progress = self.Wwebview.estimatedProgress;
                
            }
            
        }
        if ([keyPath isEqualToString:@"canGoBack"]) {
            
            if (self.Wwebview.canGoBack) {
                
                self.navigationItem.leftBarButtonItems = @[_backItem,_closeItem];
                //self.tabBarController.tabBar.hidden = YES;
                self.Wwebview.scrollView.mj_header = nil;
               
            }
            else
            {
                self.navigationItem.leftBarButtonItems = @[];
                //self.tabBarController.tabBar.hidden = NO;
                self.Wwebview.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    
                    NSMutableURLRequest *baidurequset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://zhlq.nnwsl.com/index.php?s=/Wap"]];
                    NSLog(@"H5url:===%@",self.urlString);
                    [baidurequset addValue:[@YES stringValue] forHTTPHeaderField:@"mywork"];
                    
                    [self.Wwebview loadRequest:baidurequset];
                    
                    
                }];
                
                
            }
            
        }
        
        
    }
    
}

//
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"网页返回信息：%@",message);
    if ([message isEqualToString:@"logout"]) {
            
            completionHandler();
     
    }
   else if ([message isEqualToString:@"payorder"])
   {
       NSLog(@"支付支付");
       completionHandler();
      
    
    }
    else
    {
        completionHandler();
    }
    
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
     completionHandler(YES);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    completionHandler(@"不传");
}

#pragma mark - local Data

- (void)saveHtml{
    

    [self.Wwebview evaluateJavaScript:@"document.documentElement.innerHTML" completionHandler:^(id _Nullable html, NSError * _Nullable error) {
        
        [self writetoLocal:(NSString *)html];
        
    }];
    
}
- (void)writetoLocal:(NSString *)html{
    //获取沙盒目录
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path     = [pathArr lastObject];
    NSLog(@"%@====",path);
    NSLog(@"%@++++",[[NSBundle mainBundle] bundlePath]);
    NSString *realpath = [path stringByAppendingString:@"/local.text"];
    NSError *saveErr;
    
    [html writeToFile:realpath atomically:YES encoding:NSUTF8StringEncoding error:&saveErr];
    if (saveErr) {
        NSLog(@"保存失败");
    }
}
- (NSString *)readLocalHtmlString{
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path = [pathArr lastObject];
    
    NSString *realpath = [path stringByAppendingString:@"/local.text"];
    
    NSString *htmlstr = [NSString stringWithContentsOfFile:realpath encoding:NSUTF8StringEncoding error:nil];
#warning css js 不生效
    return htmlstr;
}

- (void)dealloc
{
    self.Wwebview.scrollView.delegate  = nil;
    [self.Wwebview removeObserver:self forKeyPath:@"estimatedProgress"];
   
    [self.Wwebview removeObserver:self forKeyPath:@"canGoBack"];
    [self.Wwebview removeFromSuperview];
    self.Wwebview = nil;
    
}


@end

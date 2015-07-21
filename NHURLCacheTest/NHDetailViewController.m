//
//  NHDetailViewController.m
//  NHWebOffCachePro
//
//  Created by hu jiaju on 15-7-20.
//  Copyright (c) 2015年 Nanhu. All rights reserved.
//

#import "NHDetailViewController.h"
#import "URLCacheLib.h"

@interface NHDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, assign)BOOL isWebLoading;
@property (nonatomic, copy)NSString *webTitle,*webURL;
@property (nonatomic, strong)UIButton *backBtn,*closeBtn,*refreshBtn;

@end

@implementation NHDetailViewController

-(id)initWithTitle:(NSString *)title withRequestURL:(NSString *)url{
    self = [super initWithNibName:nil bundle:Nil];
    if (self) {
        [self setWebTitle:title];
        _webURL = url?url:nil;
        URLCacheLib *urlCache = [[URLCacheLib alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [URLCacheLib setSharedURLCache:urlCache];
    }
    return self;
}

-(void)dealloc{
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    [self removeObserver:self forKeyPath:@"isWebLoading"];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //navigationBar setting
    [self setWebTitle:_webTitle];
    [self addObserver:self forKeyPath:@"isWebLoading" options:NSKeyValueObservingOptionNew context:nil];
    
    //初始化web引擎
    [self initWebEngine];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequest];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    URLCacheLib *urlCache = (URLCacheLib *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

-(void)setWebTitle:(NSString *)webTitle{
    if (!webTitle) {
        return;
    }
    _webTitle = webTitle;
    self.title = _webTitle;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (keyPath && [keyPath isEqualToString:@"isWebLoading"]) {
        //NSLog(@"keyPath:%@",keyPath);
        self.view.userInteractionEnabled = false;
        self.navigationItem.rightBarButtonItem.enabled = !_isWebLoading;
        self.view.userInteractionEnabled = true;
    }
}

-(void)initWebEngine{
    CGRect infoRect = self.view.bounds;
    _webView = [[UIWebView alloc] initWithFrame:infoRect];
    [_webView setDelegate:self];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:_webView];
}
#pragma mark - UIWebView 委托方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return true;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"failed:%@",[error description]);
}

#pragma mark - 公共属性方法
-(void)loadRequest{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webURL]];
    [_webView loadRequest:request];
}

-(void)reloadRequest{
    if (_webView) {
        [_webView reload];
    }
}

-(void)openAppStore:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

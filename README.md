# loadLocalWebResource
iOS 通过webview加载本地web资源

实现思路：
***在iOS端启动一个本地HTTP服务器，将Web资源路径设置为服务器的根目录，使用webview访问本地服务器即可。***

###具体步骤：
需要的资源：
1.iOS端通过cocoapods集成CVCocoaHTTPServeriOS。
2.将静态打包后的资源文件拖入项iOS目中，添加时选择Create floder references方式

![添加后的样式](https://upload-images.jianshu.io/upload_images/667055-0e2fce79f2207797.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

以上，所有资源已备齐，接下来是关键代码。

1.启动服务器
```
#import <CVCocoaHTTPServeriOS/CVCocoaHTTPServeriOS-umbrella.h>

- (void)startServer{
    HTTPServer *server = [[HTTPServer alloc] init];
    [server setType:@"_http.tcp"];
    NSString * localPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"webpack"];
    [server setDocumentRoot:localPath];
    NSError *error;
    NSString *portStr;
    if ([server start:&error]) {
        UInt16 port = [self.localHttpServer listeningPort];
        portStr = [NSNumber numberWithInt:port].stringValue;
        NSLog(@"服务器启动成功-->端口号:%@",portStr);
    } else {
        NSLog(@"服务器启动出错-->%@",error);
    }
}
```

2.webview加载本地web资源

```
- (void)setWebview{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)loadLocalHttpServer{
    NSString *str = [NSString stringWithFormat:@"http://localhost:%@", port];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
     NSLog(@"加载完成");
}

```


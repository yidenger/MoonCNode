//
//  MoonTopicReplyCell.m
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicReplyCell.h"

@implementation MoonTopicReplyCell

//
//  MoonTopicDetailsCell.m
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicDetailsCell.h"
#import <WebKit/WebKit.h>
#include <SDWebImage/UIImageView+WebCache.h>

@interface MoonTopicDetailsCell()<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

//头像
@property(nonatomic, weak)UIImageView *avatarImgView;
//作者
@property(nonatomic, weak)UILabel *authorLabel;
//创建时间
@property(nonatomic, weak)UILabel *createAtLabel;
//浏览数
@property(nonatomic, weak)UILabel *visitedLabel;
//标签（置顶or精华or分享or问答or招聘）
@property(nonatomic, weak)UIButton *tabBtn;
//标题
@property(nonatomic, weak)UILabel *titleLabel;
//正文
//@property(nonatomic, weak)WKWebView *contentWebView;

@property(nonatomic, weak)UIWebView *contentWebView;

@property(nonatomic, assign)CGFloat contentWebViewHeight;

@property(nonatomic, assign)CGFloat cellHeight;


@end


@implementation MoonTopicDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //这里添加子控件
        
        //头像
        UIImageView *avatarImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:avatarImgView];
        self.avatarImgView = avatarImgView;
        //作者
        UILabel *authorLabel = [[UILabel alloc]init];
        [self.contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
        //创建时间
        UILabel *createAtLabel = [[UILabel alloc]init];
        [self.contentView addSubview: createAtLabel];
        self.createAtLabel = createAtLabel;
        //标签
        UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBtn.layer.cornerRadius = 3;
        [self.contentView addSubview: tabBtn];
        self.tabBtn = tabBtn;
        //标题
        UILabel *titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //浏览数
        UILabel *visitedLabel = [[UILabel alloc]init];
        [self.contentView addSubview:visitedLabel];
        self.visitedLabel = visitedLabel;
        
        
        UIWebView *contentWebView = [[UIWebView alloc]init];
        contentWebView.scrollView.scrollEnabled = NO;
        contentWebView.delegate = self;
        
        //        contentWebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        
        [self.contentView addSubview:contentWebView];
        
        
        self.contentWebView = contentWebView;
        
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    //这里计算子控件frame
    self.titleLabel.frame = self.topicDetailFrame.titleFrame;
    
    self.avatarImgView.frame = self.topicDetailFrame.avatarImgFrame;
    
    //设置成圆形头像
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.frame.size.width/2;
    self.avatarImgView.layer.masksToBounds = YES;
    
    self.createAtLabel.frame = self.topicDetailFrame.createAtFrame;
    self.tabBtn.frame = self.topicDetailFrame.tabBtnFrame;
    self.visitedLabel.frame = self.topicDetailFrame.visitedFrame;
    self.contentWebView.frame = self.topicDetailFrame.contentWebViewFrame;
    
    
}

-(void)setTopicDetailFrame:(MoonTopicDetailsFrame *)topicDetailFrame{
    
    _topicDetailFrame = topicDetailFrame;
    
    NSString *tabName = nil;
    UIColor *tabBtnBackgroundColor = nil;
    if ([self.topicDetailFrame.topic.tab isEqualToString:@"ask"]) {
        tabName = @"问答";
        tabBtnBackgroundColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    }
    else if([self.topicDetailFrame.topic.tab isEqualToString:@"job"]){
        tabName = @"招聘";
        tabBtnBackgroundColor = [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1];
    }
    else if([self.topicDetailFrame.topic.tab isEqualToString:@"share"]){
        tabName = @"分享";
        tabBtnBackgroundColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    }
    else{
        tabName = @"其他";
        tabBtnBackgroundColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    }
    
    if (self.topicDetailFrame.topic.good) {
        tabName = @"精华";
        tabBtnBackgroundColor = [UIColor colorWithRed:230/255.0 green:126/255.0 blue:34/255.0 alpha:1];
    }
    
    if (self.topicDetailFrame.topic.top) {
        tabName = @"置顶";
        tabBtnBackgroundColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    }
    
    [self.tabBtn setTitle:tabName forState:UIControlStateNormal];
    [self.tabBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.tabBtn.backgroundColor = tabBtnBackgroundColor;
    
    self.titleLabel.text = self.topicDetailFrame.topic.title;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.authorLabel.text = self.topicDetailFrame.topic.person.loginName;
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    
    self.createAtLabel.text = self.topicDetailFrame.topic.create_at;
    self.createAtLabel.font = [UIFont systemFontOfSize:12];
    
    
    NSString *visitedLabelText = [NSString stringWithFormat:@"%ld次浏览", (long)self.topicDetailFrame.topic.visit_count];
    self.visitedLabel.font = [UIFont systemFontOfSize:14];
    NSRange range =NSMakeRange(0, [NSString stringWithFormat:@"%ld", (long)self.topicDetailFrame.topic.visit_count].length);
    NSMutableAttributedString *attr= [[NSMutableAttributedString alloc]initWithString:visitedLabelText];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:66/255.0 green:185/255.0 blue:138/255.0 alpha:1] range:range];
    self.visitedLabel.attributedText = attr;
    
    //使用GCD加载网络图片
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    //    dispatch_async(queue, ^{
    //
    //        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.topicDetailFrame.topic.person.avatar_url]]];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            self.avatarImgView.image = image;
    //        });
    //
    //    });
    
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.topicDetailFrame.topic.person.avatar_url] placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    NSString *css = @"<head><style>a{text-decoration:none;}img{max-width:294px !important;}</style></head>";
    //    NSString *css = @"<head><style>a{text-decoration:none;}</style></head>";
    NSString *contentText  = [self.topicDetailFrame.topic.content stringByReplacingOccurrencesOfString:@"src=\"//" withString:@"src=\"http://"];
    NSString *html = [NSString stringWithFormat:@"<body><div id='details'>%@</div></body>", contentText];
    
    [self.contentWebView loadHTMLString:[css stringByAppendingString:html] baseURL:nil];
    
    
}


-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"you click a link...");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

-(CGFloat)contentWebViewHeight{
    if (!_contentWebViewHeight) {
        return 1;
    }
    return _contentWebViewHeight;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return YES;
    } else {
        [[UIApplication sharedApplication] openURL:request.URL];
    }
    return NO;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载。。。");
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成...s");
    
    //背景颜色
    //    [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.body.style.background= 'red'"];
    //字体大小
    [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTextSizeAdjust= '100%'"];
    
    
    CGFloat height = [[self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    CGRect frame = self.contentWebView.frame;
    self.contentWebView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    self.cellHeight = CGRectGetMaxY(self.contentWebView.frame) + 40;
    self.topicDetailFrame.cellHeight = CGRectGetMaxY(self.contentWebView.frame) + 20;
    
    //    self.contentWebView.scalesPageToFit = YES;
    if (height != self.contentWebViewHeight) {
        NSLog(@"&&&&&&&&&&!======");
        self.contentWebViewHeight = height;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getDoneHeight" object:[NSNumber numberWithFloat:self.cellHeight]];
    }
    else{
      
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"加载失败。。。%@", error);
}





@end


@end

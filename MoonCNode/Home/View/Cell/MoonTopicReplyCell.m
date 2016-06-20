//
//  MoonTopicReplyCell.m
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicReplyCell.h"
#import <WebKit/WebKit.h>
#include <SDWebImage/UIImageView+WebCache.h>

//
//  MoonTopicDetailsCell.m
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicDetailsCell.h"


@interface MoonTopicReplyCell()<UIWebViewDelegate>

//头像
@property(nonatomic, weak)UIImageView *avatarImgView;
//作者
@property(nonatomic, weak)UILabel *authorLabel;
//创建时间
@property(nonatomic, weak)UILabel *createAtLabel;

@property(nonatomic, weak)UIWebView *contentWebView;

@property(nonatomic, weak)UIImageView *zanImgView;
@property(nonatomic, weak)UIImageView *replyImgView;






@end



@implementation MoonTopicReplyCell



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
        
        //赞标志
        UIImageView *zanImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:zanImgView];
        self.zanImgView = zanImgView;
        
        //回复标志
        UIImageView *replyImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:replyImgView];
        self.replyImgView = replyImgView;
        
        UIWebView *contentWebView = [[UIWebView alloc]init];
        contentWebView.scrollView.scrollEnabled = NO;
        contentWebView.delegate = self;
        
        [self.contentView addSubview:contentWebView];
        
        
        self.contentWebView = contentWebView;
        
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    //这里计算子控件frame
    
    self.avatarImgView.frame = self.replyFrame.avatarImgFrame;
    
    //设置成圆形头像
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.frame.size.width/2;
    self.avatarImgView.layer.masksToBounds = YES;
    
    self.authorLabel.frame = self.replyFrame.authorFrame;
    
    self.zanImgView.frame = self.replyFrame.zanFrame;
    self.replyImgView.frame = self.replyFrame.replyFrame;
    
    self.createAtLabel.frame = self.replyFrame.createAtFrame;
    self.contentWebView.frame = self.replyFrame.contentWebViewFrame;
    
    
}

-(void)setReplyFrame:(MoonTopicReplyFrame *)replyFrame{
    
    _replyFrame = replyFrame;
    
    self.authorLabel.text = self.replyFrame.replyModel.person.loginName;
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    
    self.zanImgView.image = [UIImage imageNamed:@"zan"];
    self.replyImgView.image = [UIImage imageNamed:@"reply"];
    
    self.createAtLabel.text = self.replyFrame.replyModel.create_at;
    self.createAtLabel.font = [UIFont systemFontOfSize:12];

    
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.replyFrame.replyModel.person.avatar_url] placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    NSString *css = @"<head><style>a{text-decoration:none;}img{max-width:294px !important;}</style></head>";
    //    NSString *css = @"<head><style>a{text-decoration:none;}</style></head>";
    NSString *contentText  = [self.replyFrame.replyModel.content stringByReplacingOccurrencesOfString:@"src=\"//" withString:@"src=\"http://"];
    NSString *html = [NSString stringWithFormat:@"<body><div id='details'>%@</div></body>", contentText];
    
    [self.contentWebView loadHTMLString:[css stringByAppendingString:html] baseURL:nil];
    
    
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
    
    self.replyFrame.cellHeight = CGRectGetMaxY(self.contentWebView.frame) + 10;
    
    if (height != self.contentWebViewHeight) {
        NSLog(@"&&&&&&&&&&!======");
        self.contentWebViewHeight = height;
        self.cellHeight = CGRectGetMaxY(self.contentWebView.frame) + 10;
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"getDoneHeight" object:[NSNumber numberWithFloat:self.cellHeight]];
    }
    else{
      
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"加载失败。。。%@", error);
}





@end


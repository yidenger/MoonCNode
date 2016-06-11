//
//  MoonTopicCell.m
//  MoonCNode
//
//  Created by seth on 16/6/3.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicCell.h"

@interface MoonTopicCell()

//头像
@property(nonatomic, weak)UIImageView *avatarImgView;
//作者
@property(nonatomic, weak)UILabel *authorLabel;
//创建时间
@property(nonatomic, weak)UILabel *createAtLabel;
//最后回复时间
@property(nonatomic, weak)UILabel *lastReplyLabel;
//回复&浏览数
@property(nonatomic, weak)UILabel *replyAndVisitedLabel;
//标签（置顶or精华or分享or问答or招聘）
@property(nonatomic, weak)UIButton *tabBtn;
//标题
@property(nonatomic, weak)UILabel *titleLabel;


@end

@implementation MoonTopicCell

//在这个方法中添加子控件
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //这里添加控件
        //头像
        UIImageView *avatarImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:avatarImgView];
        self.avatarImgView = avatarImgView;
        //作者
        UILabel *authorLabel = [[UILabel alloc]init];
        [self.contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
        authorLabel.adjustsFontSizeToFitWidth = YES;
        //创建时间
        UILabel *createAtLabel = [[UILabel alloc]init];
        [self.contentView addSubview:createAtLabel];
        self.createAtLabel = createAtLabel;
        self.createAtLabel.adjustsFontSizeToFitWidth = YES;
        //最后回复时间
        UILabel *lastReplyLabel = [[UILabel alloc]init];
        lastReplyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lastReplyLabel];
        self.lastReplyLabel = lastReplyLabel;
        self.lastReplyLabel.adjustsFontSizeToFitWidth = YES;
        //回复&浏览数
        UILabel *replyAndVisitedLabel = [[UILabel alloc]init];
        replyAndVisitedLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:replyAndVisitedLabel];
        self.replyAndVisitedLabel = replyAndVisitedLabel;
        self.replyAndVisitedLabel.adjustsFontSizeToFitWidth = YES;
        //标签
        UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBtn.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:tabBtn];
        self.tabBtn = tabBtn;
        self.tabBtn.layer.cornerRadius = 3;
        //标题
        UILabel *titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
//        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    
    return self;

}

//在这个方法中设置子控件frame
-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.avatarImgView.frame = self.topicFrame.avatarImgFrame;
    //设置圆形图片
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.frame.size.width / 2;
    self.avatarImgView.layer.masksToBounds = YES;
    
    self.authorLabel.frame = self.topicFrame.authorFrame;
    
    self.createAtLabel.frame = self.topicFrame.createAtFrame;
    self.lastReplyLabel.frame = self.topicFrame.lastReplyFrame;
    self.replyAndVisitedLabel.frame = self.topicFrame.replyAndVisitedFrame;
    self.tabBtn.frame = self.topicFrame.tabBtnFrame;
    self.titleLabel.frame = self.topicFrame.titleFrame;
    

}

//在这个方法里设置子控件数据
-(void)setTopicFrame:(MoonTopicFrame *)topicFrame{
    
    _topicFrame = topicFrame;
    
    NSString *tabName = nil;
    UIColor *tabBtnBackgroundColor = nil;
    if ([self.topicFrame.topic.tab isEqualToString:@"ask"]) {
        tabName = @"问答";
        tabBtnBackgroundColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    }
    else if([self.topicFrame.topic.tab isEqualToString:@"job"]){
        tabName = @"招聘";
        tabBtnBackgroundColor = [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1];
    }
    else if([self.topicFrame.topic.tab isEqualToString:@"share"]){
        tabName = @"分享";
        tabBtnBackgroundColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    }
    else{
        tabName = @"其他";
        tabBtnBackgroundColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
    }
    
    if (self.topicFrame.topic.good) {
        tabName = @"精华";
        tabBtnBackgroundColor = [UIColor colorWithRed:230/255.0 green:126/255.0 blue:34/255.0 alpha:1];
    }
    
    if (self.topicFrame.topic.top) {
        tabName = @"置顶";
        tabBtnBackgroundColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    }
    
    [self.tabBtn setTitle:tabName forState:UIControlStateNormal];
    [self.tabBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.tabBtn.backgroundColor = tabBtnBackgroundColor;
    
    self.titleLabel.text = self.topicFrame.topic.title;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.authorLabel.text = self.topicFrame.topic.person.loginName;
    self.authorLabel.font = [UIFont systemFontOfSize:14];
    
    self.createAtLabel.text = self.topicFrame.topic.create_at;
    self.createAtLabel.font = [UIFont systemFontOfSize:12];

    self.lastReplyLabel.text = self.topicFrame.topic.last_reply_at;
    self.lastReplyLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *replyAndVisitedLabelText = [NSString stringWithFormat:@"%ld/%ld", self.topicFrame.topic.reply_count, (long)self.topicFrame.topic.visit_count];
    self.replyAndVisitedLabel.font = [UIFont systemFontOfSize:14];
    NSRange range =NSMakeRange(0, [NSString stringWithFormat:@"%ld", (long)self.topicFrame.topic.reply_count].length);
    NSMutableAttributedString *attr= [[NSMutableAttributedString alloc]initWithString:replyAndVisitedLabelText];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:66/255.0 green:185/255.0 blue:138/255.0 alpha:1] range:range];
    self.replyAndVisitedLabel.attributedText = attr;
    
//  self.avatarImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: self.topicFrame.topic.person.avatar_url]]];
    
    //使用GCD加载网络图片
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.topicFrame.topic.person.avatar_url]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.avatarImgView.image = image;
        });
    
    });
    
}


@end

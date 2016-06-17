//
//  MoonTopicFrame.m
//  MoonCNode
//
//  Created by seth on 16/6/7.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicFrame.h"

@implementation MoonTopicFrame

-(void)setTopic:(MoonTopicModel *)topic{

    _topic = topic;

    //标签
    CGFloat tabBtnX = 13.0f;
    CGFloat tabBtnY = 10.0f;
    CGFloat tabBtnWidth = 36.0f;
    CGFloat tabBtnHeight = 24.0f;
    _tabBtnFrame = CGRectMake(tabBtnX, tabBtnY, tabBtnWidth, tabBtnHeight);
    
    //标题
    CGFloat titleX = CGRectGetMaxX(self.tabBtnFrame) + 12;
    CGFloat titleY = CGRectGetMinY(self.tabBtnFrame);
    CGFloat titleWidth = [UIScreen mainScreen].bounds.size.width - titleX -22;
    CGFloat titleHeight = tabBtnHeight;
    _titleFrame = CGRectMake(titleX, titleY, titleWidth, titleHeight);
    
    //头像
    CGFloat avatarX = CGRectGetMinX(self.tabBtnFrame);
    CGFloat avatarY = CGRectGetMaxY(self.tabBtnFrame) + 10;
    CGFloat avatarWidth = 42;
    CGFloat avatarHeight = avatarWidth;
    _avatarImgFrame = CGRectMake(avatarX, avatarY, avatarWidth, avatarHeight);
    
    //作者
    CGFloat authorX = CGRectGetMinX(self.titleFrame);
    CGFloat authorY = CGRectGetMinY(self.avatarImgFrame);
    CGFloat authorWidth = 115.0f;
    CGFloat authorHeight = 20.0f;
//    CGSize authorSize = [self.topic.person.loginName boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    _authorFrame = CGRectMake(authorX, authorY, authorWidth, authorHeight);
    
    //创建时间
    CGFloat createAtX = CGRectGetMinX(self.authorFrame);
    CGFloat createAtY = CGRectGetMaxY(self.authorFrame) + 5;
    CGFloat createAtWidth = 60.0f;
    CGFloat createAtHeight = 14.0f;
    _createAtFrame = CGRectMake(createAtX, createAtY, createAtWidth, createAtHeight);
    
    //回复&浏览
    CGFloat replyAndVisitedX = 178.0f;
    CGFloat replyAndVisitedY = CGRectGetMinY(self.authorFrame);
    CGFloat replyAndVisitedWidth = 120.0f;
    CGFloat replyAndVisitedHeight = self.authorFrame.size.height;
    
    _replyAndVisitedFrame = CGRectMake(replyAndVisitedX, replyAndVisitedY, replyAndVisitedWidth, replyAndVisitedHeight);
    
    //最后回复时间
    CGFloat lastReplyX = CGRectGetMinX(self.replyAndVisitedFrame);
    CGFloat lastReplyY = CGRectGetMaxY(self.replyAndVisitedFrame) + 5;
    CGFloat lastReplyWidth = self.replyAndVisitedFrame.size.width;
    CGFloat lastReplyHeight = self.createAtFrame.size.height;
    _lastReplyFrame = CGRectMake(lastReplyX, lastReplyY, lastReplyWidth, lastReplyHeight);

    //计算高度
    self.cellHeight = 95.0f;

    
}

@end

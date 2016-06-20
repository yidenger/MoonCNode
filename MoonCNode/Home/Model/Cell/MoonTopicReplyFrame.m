//
//  MoonTopicReplyFrame.m
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicReplyFrame.h"

@implementation MoonTopicReplyFrame

-(void)setReplyModel:(MoonTopicReplyModel *)replyModel{
    
    NSLog(@"******set topic details frame...");
    _replyModel = replyModel;
    
    
    //头像
    CGFloat avatarX = 13.0f;
    CGFloat avatarY = 13;
    CGFloat avatarWidth = 42;
    CGFloat avatarHeight = avatarWidth;
    self.avatarImgFrame = CGRectMake(avatarX, avatarY, avatarWidth, avatarHeight);
    
    //作者
    CGFloat authorX = CGRectGetMaxX(self.avatarImgFrame) + 12;
    CGFloat authorY = CGRectGetMinY(self.avatarImgFrame);
    CGFloat authorWidth = 115.0f;
    CGFloat authorHeight = 20.0f;
    //    CGSize authorSize = [self.topic.person.loginName boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    self.authorFrame = CGRectMake(authorX, authorY, authorWidth, authorHeight);
    
    //回复
    CGFloat replyY = CGRectGetMinY(self.authorFrame);
    CGFloat replyHeight = self.authorFrame.size.height;
    CGFloat replyWidth = replyHeight;
    CGFloat replyX = [UIScreen mainScreen].bounds.size.width - 13 - replyWidth;
    self.replyFrame = CGRectMake(replyX, replyY, replyWidth, replyHeight);
    
    //赞
    CGFloat zanY = self.replyFrame.origin.y;
    CGFloat zanHeight = self.replyFrame.size.height;
    CGFloat zanWidth = self.replyFrame.size.width;
    CGFloat zanX = self.replyFrame.origin.x - 15 - zanWidth;
    self.zanFrame = CGRectMake(zanX, zanY, zanWidth, zanHeight);
    
    //创建时间
    CGFloat createAtX = CGRectGetMinX(self.authorFrame);
    CGFloat createAtY = CGRectGetMaxY(self.authorFrame) + 5;
    CGFloat createAtWidth = 60.0f;
    CGFloat createAtHeight = 14.0f;
    self.createAtFrame = CGRectMake(createAtX, createAtY, createAtWidth, createAtHeight);

    
    //正文
    CGFloat contentX = CGRectGetMinX(self.avatarImgFrame);
    CGFloat contentY = CGRectGetMaxY(self.avatarImgFrame) + 20;
    CGFloat contentWidth = [[UIScreen mainScreen] bounds].size.width - 26;
    CGFloat contentHeight = 0;
    
    if (self.contentWebViewHeight > 10) {
        NSLog(@"not null>>>>>>>>>>>>>>>");
        contentHeight = self.contentWebViewHeight;
    }
    
    self.contentWebViewFrame = CGRectMake(contentX, contentY, contentWidth, contentHeight);
    
    //计算高度
    self.cellHeight = CGRectGetMaxY(self.contentWebViewFrame) + 10;
    

    
}

-(CGFloat)contentWebViewHeight{
    if (_contentWebViewHeight < 10) {
        return 0;
    }
    return _contentWebViewHeight;
}

-(CGFloat)cellHeight{
    NSLog(@"******cellHeight: %f", _cellHeight);
    return _cellHeight;
    
}



@end

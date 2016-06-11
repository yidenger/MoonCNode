//
//  MoonTopicDetailsFrame.m
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicDetailsFrame.h"

@implementation MoonTopicDetailsFrame

-(void)setTopic:(MoonTopicModel *)topic{
    
    
    self.topic = topic;
    
    
    
    //标题
    CGFloat titleX = 13.0f;
    CGFloat titleY = 10.0f;
    CGFloat titleWidth = [UIScreen mainScreen].bounds.size.width - titleX -13;
    CGFloat titleHeight = 24.0f;
    self.titleFrame = CGRectMake(titleX, titleY, titleWidth, titleHeight);
    
    //头像
    CGFloat avatarX = CGRectGetMinX(self.titleFrame);
    CGFloat avatarY = CGRectGetMaxY(self.titleFrame) + 10;
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
    
    //创建时间
    CGFloat createAtX = CGRectGetMinX(self.authorFrame);
    CGFloat createAtY = CGRectGetMaxY(self.authorFrame) + 5;
    CGFloat createAtWidth = 60.0f;
    CGFloat createAtHeight = 14.0f;
    self.createAtFrame = CGRectMake(createAtX, createAtY, createAtWidth, createAtHeight);
    
    //标签
    CGFloat tabBtnY = CGRectGetMinY(self.authorFrame);
    CGFloat tabBtnWidth = 36.0f;
    CGFloat tabBtnHeight = 24.0f;
    CGFloat tabBtnX = [UIScreen mainScreen].bounds.size.width - 13- tabBtnWidth;
    self.tabBtnFrame = CGRectMake(tabBtnX, tabBtnY, tabBtnWidth, tabBtnHeight);
    
    //浏览
    CGFloat visitedY = CGRectGetMinY(self.createAtFrame);
    CGFloat visitedWidth = 120.0f;
    CGFloat visitedHeight = self.authorFrame.size.height;
    CGFloat visitedX = [UIScreen mainScreen].bounds.size.width - 13 - visitedWidth;
    self.visitedFrame = CGRectMake(visitedX, visitedY, visitedWidth, visitedHeight);
    
    //正文
    CGFloat contentX = CGRectGetMinX(self.avatarImgFrame);
    CGFloat contentY = CGRectGetMaxY(self.avatarImgFrame) + 20;
    CGFloat contentWidth = self.titleFrame.size.width;

    
    
    //计算高度
    self.cellHeight = 95.0f;
    
    
    
    
}

@end

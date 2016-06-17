//
//  MoonTopicDetailsFrame.h
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicFrame.h"
#import "MoonTopicModel.h"

@interface MoonTopicDetailsFrame : NSObject

@property(nonatomic, strong)MoonTopicModel *topic;
@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGFloat contentWebViewHeight;
//控件frame
@property(nonatomic, assign)CGRect avatarImgFrame;
@property(nonatomic, assign)CGRect authorFrame;
@property(nonatomic, assign)CGRect createAtFrame;
@property(nonatomic, assign)CGRect lastReplyFrame;
@property(nonatomic, assign)CGRect replyAndVisitedFrame;
@property(nonatomic, assign)CGRect tabBtnFrame;
@property(nonatomic, assign)CGRect titleFrame;

@property(nonatomic, assign)CGRect visitedFrame;

@property(nonatomic, assign)CGRect contentWebViewFrame;

@end

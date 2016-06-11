//
//  MoonTopicFrame.h
//  MoonCNode
//
//  Created by seth on 16/6/7.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#import "MoonTopicModel.h"

@interface MoonTopicFrame : NSObject

@property(nonatomic, strong)MoonTopicModel *topic;
@property(nonatomic, assign)CGFloat cellHeight;
//控件frame
@property(nonatomic, assign)CGRect avatarImgFrame;
@property(nonatomic, assign)CGRect authorFrame;
@property(nonatomic, assign)CGRect createAtFrame;
@property(nonatomic, assign)CGRect lastReplyFrame;
@property(nonatomic, assign)CGRect replyAndVisitedFrame;
@property(nonatomic, assign)CGRect tabBtnFrame;
@property(nonatomic, assign)CGRect titleFrame;

@end

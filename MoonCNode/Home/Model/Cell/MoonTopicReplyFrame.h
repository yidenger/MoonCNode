//
//  MoonTopicReplyFrame.h
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MoonTopicReplyModel.h"

@interface MoonTopicReplyFrame : NSObject

@property(nonatomic, strong)MoonTopicReplyModel *replyModel;
@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGFloat contentWebViewHeight;
//控件frame
@property(nonatomic, assign)CGRect avatarImgFrame;
@property(nonatomic, assign)CGRect authorFrame;
@property(nonatomic, assign)CGRect createAtFrame;
@property(nonatomic, assign)CGRect contentWebViewFrame;

@end

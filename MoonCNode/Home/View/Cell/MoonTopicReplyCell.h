//
//  MoonTopicReplyCell.h
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoonTopicReplyFrame.h"

@interface MoonTopicReplyCell : UITableViewCell

@property(nonatomic,strong)MoonTopicReplyFrame *replyFrame;
@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGFloat contentWebViewHeight;

@end

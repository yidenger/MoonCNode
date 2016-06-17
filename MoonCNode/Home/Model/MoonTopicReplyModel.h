//
//  MoonTopicReplyModel.h
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonPerson.h"

@interface MoonTopicReplyModel : NSObject

@property(nonatomic, copy)NSString *create_id; //创建id
@property(nonatomic, strong)MoonPerson *person; //作者
@property(nonatomic, copy)NSString *content; //回复内容
@property(nonatomic, copy)NSString *create_at; //回复时间
@property(nonatomic, copy)NSString *reply_id; //回复id
@property(nonatomic, strong)NSArray *ups; //未知？

@end

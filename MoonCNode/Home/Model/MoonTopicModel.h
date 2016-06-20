//
//  MoonTopicModel.h
//  MoonCNode
//
//  Created by seth on 16/6/3.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoonPerson.h"

@interface MoonTopicModel : NSObject

//话题id
@property(nonatomic, copy)NSString *topic_id;
//作者id
@property(nonatomic, copy)NSString *author_id;
//分类
@property(nonatomic, copy)NSString *tab;
//内容
@property(nonatomic, copy)NSString *content;
//标题
@property(nonatomic, copy)NSString *title;
//最后回复时间
@property(nonatomic, copy)NSString *last_reply_at;
//是否精华
@property(nonatomic, assign)BOOL good;
//是否置顶
@property(nonatomic, assign)BOOL top;
//回复数量
@property(nonatomic, assign)NSInteger reply_count;
//阅览数量
@property(nonatomic, assign)NSInteger visit_count;
//创建时间
@property(nonatomic, copy)NSString *create_at;
//作者
@property(nonatomic, strong)MoonPerson *person;


@end

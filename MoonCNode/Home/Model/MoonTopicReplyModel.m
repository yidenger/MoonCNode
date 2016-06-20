//
//  MoonTopicReplyModel.m
//  MoonCNode
//
//  Created by seth on 16/6/17.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicReplyModel.h"
#import "NSString+Extension.h"

@implementation MoonTopicReplyModel

-(NSString *)create_at{
    NSString *dateString = [_create_at getLocalDateFormateUTCDate];
    return [dateString compareCurrentTime];
}

@end

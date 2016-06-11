//
//  MoonTopicModel.m
//  MoonCNode
//
//  Created by seth on 16/6/3.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicModel.h"
#import "NSString+Extension.h"

@implementation MoonTopicModel

-(NSString *)create_at{
    NSString *dateString = [_create_at getLocalDateFormateUTCDate];
    return [dateString compareCurrentTime];
}

-(NSString *)last_reply_at{

    NSString *dateString = [_last_reply_at getLocalDateFormateUTCDate];
    return [dateString compareCurrentTime];
}


@end

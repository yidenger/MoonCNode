//
//  NSString+Extension.h
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51.345Z

/**
 *  将UTC日期字符串转为本地时间字符串
 *
 *  @param utcDate 输入的UTC日期格式2013-08-03T04:53:51.345Z
 *
 *  @return 本地时间字符串(格式: yyyy-MM-dd HH:mm:ss)
 */
-(NSString *)getLocalDateFormateUTCDate;

//

/**
 *  时间字符串距离现在多长时间（几分钟前，几天前，几年前）
 *
 *  @param str 时间字符串（格式: yyyy-MM-dd HH:mm:ss）
 *
 *  @return  距离现在多长时间字符串(eg: 1分钟前)
 */
- (NSString *)compareCurrentTime;


@end

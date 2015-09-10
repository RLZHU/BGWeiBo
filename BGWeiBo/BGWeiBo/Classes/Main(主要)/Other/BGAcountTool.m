//
//  BGAcountTool.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGAcountTool.h"
#import "BGAcount.h"

#define BGAcountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation BGAcountTool
//保存帐号信息
+ (void)saveAcount:(BGAcount *)acount{
    
    [NSKeyedArchiver archiveRootObject:acount toFile:BGAcountPath];
}

//取出帐号信息
+ (BGAcount *)acount{
    BGAcount *acount = [NSKeyedUnarchiver unarchiveObjectWithFile:BGAcountPath];
    
    /* 取出帐号信息 */
    // 过期的秒数
    long long expires_in = [acount.expires_in longLongValue];
    NSDate *expiresTime = [acount.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return acount;
}
@end

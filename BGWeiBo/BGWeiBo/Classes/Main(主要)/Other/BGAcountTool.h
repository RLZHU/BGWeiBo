//
//  BGAcountTool.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BGAcount;

@interface BGAcountTool : NSObject

+ (void)saveAcount:(BGAcount *)acount;
+ (BGAcount *)acount;

@end

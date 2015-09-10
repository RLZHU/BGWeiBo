//
//  UIWindow+Extension.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "BGTabViewController.h"
#import "BGNewFeatureViewController.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController{
    
    NSString *key = @"CFBundleVersion";
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:key];
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[BGTabViewController alloc] init];
    }else {
        self.rootViewController = [[BGNewFeatureViewController alloc] init];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//必须写，防止数据丢失
    }
    
}
@end

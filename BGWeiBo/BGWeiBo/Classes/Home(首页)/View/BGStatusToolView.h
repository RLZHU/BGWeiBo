//
//  BGStatusToolView.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGStatus;

@interface BGStatusToolView : UIView

+ (instancetype)toolBar;

@property (nonatomic, strong) BGStatus *status;

@end

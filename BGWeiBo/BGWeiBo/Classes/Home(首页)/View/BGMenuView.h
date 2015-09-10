//
//  BGMenuVIew.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGMenuView;

@protocol BGMenuViewDelegate <NSObject>
@optional

- (void)menuViewWillDismiss:(BGMenuView *)view;
- (void)menuViewDidShow:(BGMenuView *)view;

@end

@interface BGMenuView : UIView

+ (instancetype)menu;
- (void)showFrom:(UIView *)from;

@property (nonatomic, strong) UIView *content;
@property (nonatomic, weak) id<BGMenuViewDelegate> delegate;

//这个contentController的意义在于，强引用创建的那个viewController,否则没有强指针指着viewController很快就会销毁
@property (nonatomic, strong) UIViewController *contentController;

@end

//
//  BGComposeToolBar.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BGComposeToolbarButtonTypeCamera, // 拍照
    BGComposeToolbarButtonTypePicture, // 相册
    BGComposeToolbarButtonTypeMention, // @
    BGComposeToolbarButtonTypeTrend, // #
    BGComposeToolbarButtonTypeEmotion // 表情
} BGComposeToolbarButtonType;

@class BGComposeToolbar;

@protocol BGComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(BGComposeToolbar *)toolbar didClickButton:(BGComposeToolbarButtonType)buttonType;
@end

@interface BGComposeToolbar : UIView
@property (nonatomic, weak) id<BGComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end

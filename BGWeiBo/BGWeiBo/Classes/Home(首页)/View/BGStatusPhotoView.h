//
//  BGStatusPhotoView.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGStatusPhotoView : UIView

@property (nonatomic, strong) NSArray *photos;

+ (CGSize)sizeWithPhotoCount:(NSUInteger)count;

@end

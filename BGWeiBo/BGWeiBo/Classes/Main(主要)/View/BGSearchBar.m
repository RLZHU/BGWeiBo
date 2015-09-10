//
//  BGSearchBar.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGSearchBar.h"
#import "UIView+Extexsion.h"

@implementation BGSearchBar

+ (instancetype)searchBar{
    return [[self alloc] init];
}

//UIImageView通过initWithImage:的方法来创建,默认是有尺寸的
//而绝大部分空间通过init方法来创建的，都是没有尺寸的
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end

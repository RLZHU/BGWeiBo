//
//  BGStatusTableViewCell.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGStatusFrame;

@interface BGStatusTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BGStatusFrame *statusFrame;

@end

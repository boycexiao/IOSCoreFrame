//
//  XBHomeLeftTableCell.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-6.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBHomeLeftTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryNumLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedFlagView;

@end

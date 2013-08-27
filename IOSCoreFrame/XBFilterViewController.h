//
//  XBFilterViewController.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-6.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBFilterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSArray *tableDataSource;

@end

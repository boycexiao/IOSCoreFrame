//
//  ViewController.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-2.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPRevealSideViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface XBHomeViewController : UIViewController<PPRevealSideViewControllerDelegate, EGORefreshTableDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIView *test;
}

@property (weak, nonatomic) IBOutlet UIView *topButtonsView;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonsView;

@property (weak, nonatomic) IBOutlet UIView *middleContentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *contentView;




- (IBAction)handleChooseVenuesButtonTapped:(id)sender;
- (IBAction)handleAllCategoriesButtonTapped:(id)sender;
- (IBAction)handleHotestInfoButtonTapped:(id)sender;
- (IBAction)handleShakeButtonTapped:(id)sender;
- (IBAction)handleDIYButtonTapped:(id)sender;

@end

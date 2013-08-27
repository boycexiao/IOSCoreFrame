//
//  XBFilterViewController.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-6.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "XBFilterViewController.h"
#import "XBHomeLeftTableCell.h"
#import "XBHomeRightTableCell.h"

@interface XBFilterViewController ()

@property (nonatomic, assign) NSInteger leftTableSelectedIndex;
@property (nonatomic, assign) NSInteger rightTableSelectedIndex;



@end

@implementation XBFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentView.layer.cornerRadius = 5.0f;
    
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
    
    //TableDataSource 数据结构:
    
    self.tableDataSource = @[
                             @{@"category_name": @"全部频道", @"sub_categories":@[@{@"subcategory_name":@"吃的",
                                                                                @"subcategory_num":@"3"},@{@"subcategory_name":@"的",
                                                                                                           @"subcategory_num":@"3"},@{@"subcategory_name":@"喝的",
                                                                                                                                      @"subcategory_num":@"3"},@{@"subcategory_name":@"玩的",
                                                                                                                                                                 @"subcategory_num":@"3"},@{@"subcategory_name":@"吃的",
                                                                                                                                                                                            @"subcategory_num":@"3"} ]},
  @{@"category_name": @"美食", @"sub_categories":@[]},
  @{@"category_name": @"娱乐", @"sub_categories":@[]},
  @{@"category_name": @"哈哈哈", @"sub_categories":@[]},
  @{@"category_name": @"啦啦",@"sub_categories":@[]},
  @{@"category_name": @"....", @"sub_categories":@[]},
  @{@"category_name": @"飞", @"sub_categories":@[]},
  
  
  ];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDateSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.tableDataSource.count;
    } else {
        NSDictionary *data = [self.tableDataSource objectAtIndex:self.leftTableSelectedIndex];
        NSArray *subCategories = [data valueForKey:@"sub_categories"];
        return subCategories.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        static NSString *CellIdentifier = @"XBHomeLeftTableCell";
        XBHomeLeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XBHomeLeftTableCell class]) owner:nil options:nil] lastObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (self.leftTableSelectedIndex == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryNone;

            UIView *customBackgroudView =  [[UIView alloc] init];
            customBackgroudView.frame = cell.bounds;
            customBackgroudView.backgroundColor = [UIColor whiteColor];
            cell.backgroundView = customBackgroudView;
            
            cell.selectedFlagView.hidden = NO;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *customBackgroudView =  [[UIView alloc] init];
            customBackgroudView.frame = cell.bounds;
            customBackgroudView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
            cell.backgroundView = customBackgroudView;
            
            cell.selectedFlagView.hidden = YES;
        }
        
        NSDictionary *data = [self.tableDataSource objectAtIndex:indexPath.row];
        cell.categoryNameLabel.text = [data valueForKey:@"category_name"];
        cell.categoryNumLabel.text = [NSString stringWithFormat:@"%d", [[data valueForKey:@"sub_categories"] count]];
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"XBHomeRightTableCell";
        XBHomeRightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XBHomeRightTableCell class]) owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
//        if (self.rightTableSelectedIndex == indexPath.row) {
//            
//        } else {
//
//        }
        
        NSDictionary *data = [self.tableDataSource objectAtIndex:self.leftTableSelectedIndex];
        NSArray *subCategories = [data valueForKey:@"sub_categories"];
        NSDictionary *subCategory = [subCategories objectAtIndex:indexPath.row];
        cell.subCategoryNameLabel.text = [subCategory valueForKey:@"subcategory_name"];
        cell.subCategoryNumLabel.text = [subCategory valueForKey:@"subcategory_num"];

        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        self.leftTableSelectedIndex = indexPath.row;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
    } else {
        self.rightTableSelectedIndex = indexPath.row;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view removeFromSuperview];
}

@end

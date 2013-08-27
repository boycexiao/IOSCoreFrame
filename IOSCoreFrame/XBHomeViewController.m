//
//  ViewController.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-2.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#define PPRevealSideLeftOffset                  70.0f

#import "XBHomeViewController.h"
#import "XBFilterViewController.h"
#import "XBSideViewController.h"
#import "XBHomePageView.h"

#import "XBWaterFlowViewController.h"
#import "XBShakeViewController.h"
#import "XBImagePageViewController.h"

@interface XBHomeViewController ()

@property (nonatomic, strong) XBFilterViewController *chooseVenuesFilterViewController;
@property (nonatomic, strong) XBFilterViewController *allCategoriesViewController;

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;

@property (nonatomic, assign) BOOL reloading;

//Stub TableDataSource
@property (nonatomic, strong) NSMutableArray *stubDataSource;

@end

@implementation XBHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"新媒体";
    
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navBar1.png"] forBarMetrics:NO];
    
    //Stub DataSource
    self.stubDataSource = [NSMutableArray arrayWithArray:@[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"]];

//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    self.revealSideViewController.panInteractionsWhenClosed = PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar;
    self.revealSideViewController.panInteractionsWhenOpened =  PPRevealSideInteractionContentView|PPRevealSideInteractionNavigationBar;
    [self.revealSideViewController setDirectionsToShowBounce: PPRevealSideDirectionLeft];
    
    XBSideViewController *sideViewController = [[XBSideViewController alloc] initWithNibName:NSStringFromClass([XBSideViewController class]) bundle:nil];
    [self.revealSideViewController preloadViewController:sideViewController
                                                 forSide:PPRevealSideDirectionLeft
                                              withOffset:PPRevealSideLeftOffset];
    
    self.revealSideViewController.delegate = self;
    
    
    self.chooseVenuesFilterViewController = [[XBFilterViewController alloc] initWithNibName:NSStringFromClass([XBFilterViewController class]) bundle:nil];
    
    self.allCategoriesViewController  = [[XBFilterViewController alloc] initWithNibName:NSStringFromClass([XBFilterViewController class]) bundle:nil];
    
    [self setHeaderView];
    [self setFooterView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods for creating and removing the header view

-(void)setHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[self.tableView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}

-(void)setFooterView{
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(self.tableView.contentSize.height, self.tableView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.tableView.frame.size.width,
                                              self.view.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.tableView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self.tableView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

-(void)removeFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}
#pragma mark - Method that should be called when the refreshing is finished

- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    
    if (_refreshFooterView) {
        
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    
    [self setFooterView];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)pullDownToRefresh{

    //TODO:注意！在这里做refresh操作！
    self.stubDataSource = [NSMutableArray arrayWithArray:@[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"]];
    
    
    [self.tableView reloadData];
    [self finishReloadingData];
    [self setFooterView];
}

-(void)pullUpToLoadMore{
    [self removeFooterView];
    
    //TODO:注意！在这里做load more操作！
    [self.stubDataSource addObjectsFromArray:@[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"]];
    [self.tableView reloadData];
    
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark - EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	
    //  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        [self performSelector:@selector(pullDownToRefresh) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        [self performSelector:@selector(pullUpToLoadMore) withObject:nil afterDelay:2.0];
    }
    
	// overide, the actual loading data operation is done in the subclass
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - PPRevealSideViewControllerDelegate

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController
{
    self.topButtonsView.userInteractionEnabled = NO;
    self.middleContentView.userInteractionEnabled = NO;
    self.bottomButtonsView.userInteractionEnabled = NO;
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController
{
    self.topButtonsView.userInteractionEnabled = YES;
    self.middleContentView.userInteractionEnabled = YES;
    self.bottomButtonsView.userInteractionEnabled = YES;
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stubDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"XBHomeTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.stubDataSource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Button Action


- (IBAction)handleChooseVenuesButtonTapped:(id)sender {
    
    self.chooseVenuesFilterViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.chooseVenuesFilterViewController.view];
    
}

- (IBAction)handleAllCategoriesButtonTapped:(id)sender {
    
    //TEST
    XBWaterFlowViewController *viewController = [[XBWaterFlowViewController alloc] initWithNibName:NSStringFromClass([XBWaterFlowViewController class]) bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)handleHotestInfoButtonTapped:(id)sender {
}

- (IBAction)handleShakeButtonTapped:(id)sender {
    XBShakeViewController *viewController = [[XBShakeViewController alloc] initWithNibName:NSStringFromClass([XBShakeViewController class]) bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)handleDIYButtonTapped:(id)sender {
    XBImagePageViewController *viewController = [[XBImagePageViewController alloc] initWithNibName:NSStringFromClass([XBImagePageViewController class]) bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

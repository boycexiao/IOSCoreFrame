//
//  XBWaterFlowViewController.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-7.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBWaterFlowViewController.h"
#import "XBWaterFlowCell.h"

#define Default_WaterFlowCell_Width          145       

@interface XBWaterFlowViewController ()


@property (nonatomic, strong) NSArray *stubDataSource;

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;
@property (nonatomic, assign) BOOL reloading;

@end

@implementation XBWaterFlowViewController

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
    
    self.collectionView.delegate = self; // This is for UIScrollViewDelegate
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = ~UIViewAutoresizingNone;
    self.collectionView.numColsPortrait = 2;
    
    self.stubDataSource = @[
  @{@"image_url":@"http://f.hiphotos.baidu.com/pic/w%3D230/sign=960a80406a600c33f079d9cb2a4d5134/0df431adcbef7609b65fdacb2fdda3cc7cd99e0a.jpg", @"image_width":@(500), @"image_height":@(375)},
  
  @{@"image_url":@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=ceb595600ff41bd5da53eff465e280cb/aec379310a55b319586ff03e42a98226cefc17e2.jpg", @"image_width":@(511), @"image_height":@(402)},
  
  @{@"image_url":@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=d58e7140a686c91708035539fd0571cf/0824ab18972bd40775be46457a899e510fb30908.jpg", @"image_width":@(450), @"image_height":@(600)},
  
  @{@"image_url":@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=1bbd08894d086e066aa8384b36307af4/7acb0a46f21fbe09c84757ac6a600c338744ad69.jpg", @"image_width":@(500), @"image_height":@(750)},
  
  @{@"image_url":@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=150ec96a7aec54e741ec1d1e8d009a50/574e9258d109b3dea8b3a03ccdbf6c81800a4c51.jpg", @"image_width":@(570), @"image_height":@(578)},
  
  @{@"image_url":@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=4affc14810dfa9ecfd2e511756e8f603/1b4c510fd9f9d72ad875b349d52a2834349bbb55.jpg", @"image_width":@(375), @"image_height":@(500)},
  
  @{@"image_url":@"http://f.hiphotos.baidu.com/album/w%3D2048/sign=af6ce67c0bd162d985ee651c25e7a8ec/6a600c338744ebf8b728cc87d8f9d72a6059a729.jpg", @"image_width":@(480), @"image_height":@(720)},
  
  @{@"image_url":@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=bd38da50960a304e5222a7fae5f0a686/80cb39dbb6fd526690319240aa18972bd407364f.jpg", @"image_width":@(500), @"image_height":@(658)},
  
  @{@"image_url":@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=faa5999483025aafd33279cbcfd5aa64/8601a18b87d6277fb599ed6c29381f30e824fcdf.jpg", @"image_width":@(440), @"image_height":@(440)},
  
  @{@"image_url":@"http://g.hiphotos.baidu.com/album/w%3D2048/sign=bf20496e314e251fe2f7e3f893bec817/38dbb6fd5266d016f730757c962bd40735fa35bd.jpg", @"image_width":@(490), @"image_height":@(1911)}
//  ,
  
//  @{@"image_url":@"", @"image_width":@(500), @"image_height":@(375)},
//  
//  @{@"image_url":@"", @"image_width":@(500), @"image_height":@(375)},
//  
//  @{@"image_url":@"", @"image_width":@(500), @"image_height":@(375)},
//  
//  @{@"image_url":@"", @"image_width":@(500), @"image_height":@(375)},
  
  ];
    
    
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
    
	[self.collectionView addSubview:_refreshHeaderView];
    
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
    CGFloat height = MAX(self.collectionView.contentSize.height, self.collectionView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              self.collectionView.frame.size.width,
                                              self.view.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         self.collectionView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self.collectionView addSubview:_refreshFooterView];
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
        
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    }
    
    if (_refreshFooterView) {
        
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    }
    
    [self setFooterView];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)pullDownToRefresh{
    
    //TODO:注意！在这里做refresh操作！
//    self.stubDataSource = [NSMutableArray arrayWithArray:@[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"]];
    
    
    [self.collectionView reloadData];
    [self finishReloadingData];
    [self setFooterView];
}

-(void)pullUpToLoadMore{
    [self removeFooterView];
    
    //TODO:注意！在这里做load more操作！
//    [self.stubDataSource addObjectsFromArray:@[@"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test", @"test"]];
    [self.collectionView reloadData];
    
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


#pragma mark - PSCollectionViewDelegate & PSCollectionViewDataSource

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return self.stubDataSource.count;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    XBWaterFlowCell *cell = (XBWaterFlowCell *)[collectionView dequeueReusableViewForClass:[XBWaterFlowCell class]];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XBWaterFlowCell class]) owner:nil options:nil] lastObject];
    }
    
    NSDictionary *imageInfo = [self.stubDataSource objectAtIndex:index];
    cell.imageURL = [imageInfo objectForKey:@"image_url"];
    
    return cell;
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    
    NSDictionary *imageInfo = [self.stubDataSource objectAtIndex:index];
    CGFloat imageHeight = [[imageInfo objectForKey:@"image_height"] floatValue];
    CGFloat imageWidth  = [[imageInfo objectForKey:@"image_width"] floatValue];
    
    CGFloat actualHeigth = Default_WaterFlowCell_Width * imageHeight * 1.00 / imageWidth;
    
    return actualHeigth;
}


@end

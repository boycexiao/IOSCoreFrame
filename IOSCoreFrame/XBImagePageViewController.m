//
//  XBImagePageViewController.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-20.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBImagePageViewController.h"
#import "XBImagePageView.h"

@interface XBImagePageViewController ()

@property (nonatomic, strong) NSArray *stubImagePaths;

@end

@implementation XBImagePageViewController

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
    
    self.stubImagePaths = @[@"http://dc466.4shared-china.com/img/bVr9KC-8/s7/00_online.jpg",
                            @"http://dc351.4shared.com/img/DtChR6sJ/s3/Genesis.jpg",
                            @"http://www.mercedes-amg.com.tw/club/FileUpload/Car/sl63_320x180.jpg"];
    
    self.imagePagingScrollView.dataSource = self;
    self.imagePagingScrollView.delegate = self;
    [self.imagePagingScrollView reloadData];
    
    self.imagePageControl.numberOfPages = self.stubImagePaths.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NIPagingScrollViewDataSource & NIPagingScrollViewDelegate

- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView
{
    return self.stubImagePaths.count;
}

- (UIView<NIPagingScrollViewPage> *)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex
{
    UIView<NIPagingScrollViewPage>* pageView = nil;
    NSString* reuseIdentifier = @"XBImagePageView";
    pageView = [pagingScrollView dequeueReusablePageWithIdentifier:reuseIdentifier];
    if (nil == pageView) {
        pageView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XBImagePageView class]) owner:nil options:nil] lastObject];
        pageView.reuseIdentifier = reuseIdentifier;
//        pageView.backgroundColor = self.photoViewBackgroundColor;
    }
    
    NSString *imagePath = [self.stubImagePaths objectAtIndex:pageIndex];
    
    
    XBImagePageView* imagePageView = (XBImagePageView *)pageView;
    imagePageView.imagePath = imagePath;
    
    return pageView;

}

- (void)pagingScrollViewDidChangePages:(NIPagingScrollView *)pagingScrollView
{
    self.imagePageControl.currentPage = pagingScrollView.centerPageIndex;
}


@end

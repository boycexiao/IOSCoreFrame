//
//  XBImagePageViewController.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-20.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NimbusPagingScrollView.h"

@interface XBImagePageViewController : UIViewController<NIPagingScrollViewDataSource, NIPagingScrollViewDelegate>

@property (weak, nonatomic) IBOutlet NIPagingScrollView *imagePagingScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;

@end

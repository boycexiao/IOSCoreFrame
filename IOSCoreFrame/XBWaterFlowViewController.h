//
//  XBWaterFlowViewController.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-7.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface XBWaterFlowViewController : UIViewController<PSCollectionViewDelegate, PSCollectionViewDataSource, EGORefreshTableDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet PSCollectionView *collectionView;


@end

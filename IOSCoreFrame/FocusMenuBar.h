//
//  FocusMenuBar.h
//  FX_Demo
//
//  Created by lin fn on 13-7-17.
//  Copyright (c) 2013年 lin fn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FocusMenuBar;

@protocol FocusMenuBarDataSource <NSObject>
@required
- (NSInteger) numberOfMenuItems:(FocusMenuBar *) menu;
- (NSString *) menu:(FocusMenuBar *) menu titleForMenuItemAtIndex: (NSInteger) idx;
@end

@protocol FocusMenuBarDelegate <NSObject>
- (void) menu: (FocusMenuBar *) menuBar itemFocusedAtIndex: (NSInteger) idx;
@end

@interface FocusMenuBar : UIView <UIScrollViewDelegate>
{
    NSInteger numItems;
    NSInteger activeIndex;
    float subMenuWidth;
    float menuHeight;
    float scrollViewHeight;
    UIImageView * activeMenuImageView;
}
- (void) reloadData;
- (void) gotoSubMenuWithIndex:(NSInteger)index;

@property (nonatomic) IBOutlet id<FocusMenuBarDataSource> dataSource;
@property (nonatomic) IBOutlet id<FocusMenuBarDelegate> focusMenuDelegate;
@property (nonatomic) NSInteger itemFontSize;
@property (nonatomic) UIColor   *focusColor;
@property (nonatomic) UIColor   *normalColor;
@property (nonatomic) NSString  *barBackgroundPic;
@property (nonatomic) NSString  *currentBackgroundPic;
@end

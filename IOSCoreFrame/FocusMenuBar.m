//
//  FocusMenuBar.m
//  FX_Demo
//
//  Created by lin fn on 13-7-17.
//  Copyright (c) 2013年 lin fn. All rights reserved.
//


#import "FocusMenuBar.h"
#import <QuartzCore/QuartzCore.h>


#define btnTag 1000

@interface FocusMenuBar ()
@property (nonatomic) UIScrollView *sv;
@end

@implementation FocusMenuBar
@synthesize barBackgroundPic = _barBackgroundPic;
@synthesize currentBackgroundPic = _currentBackgroundPic;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        numItems = 0;
        self.itemFontSize = 18;
        activeIndex = 0;
        subMenuWidth = 80;
        menuHeight = self.frame.size.height - 8;
        scrollViewHeight = self.frame.size.height;
        
        activeMenuImageView = [[UIImageView alloc] init];
        
        self.normalColor     = [UIColor whiteColor];
        self.focusColor      = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
        
        self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , scrollViewHeight)];
        self.sv.bounces = NO;
        self.sv.scrollEnabled = YES;
        self.sv.showsHorizontalScrollIndicator = NO;
        self.sv.showsVerticalScrollIndicator = NO;
        self.sv.delegate = self;
        [self addSubview:self.sv];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        numItems = 0;
        self.itemFontSize = 18;
        activeIndex = 0;
        subMenuWidth = 80;
        menuHeight = self.frame.size.height - 8;
        scrollViewHeight = self.frame.size.height;
        
        activeMenuImageView = [[UIImageView alloc] init];
        
        self.normalColor     = [UIColor whiteColor];
        self.focusColor      = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];        
        
        self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , scrollViewHeight)];
        self.sv.bounces = NO;
        self.sv.scrollEnabled = YES;
        self.sv.showsHorizontalScrollIndicator = NO;
        self.sv.showsVerticalScrollIndicator = NO;
        self.sv.delegate = self;
        [self addSubview:self.sv];       
    }
    return self;
}

- (void)setActiveMenuBG:(NSInteger)index
{
    activeMenuImageView.frame = CGRectMake(index * subMenuWidth, 0, subMenuWidth, scrollViewHeight);
}

- (void) reloadData
{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfMenuItems:)]) {
        numItems = [self.dataSource numberOfMenuItems:self];
    }
    
    
    UIFont *buttonFont = [UIFont systemFontOfSize:self.itemFontSize];
    
    float buttonWidth = 80;
    //背景
    UIImage *img = [UIImage imageNamed:_barBackgroundPic];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    iv.frame = CGRectMake(0, 0, numItems * buttonWidth, menuHeight);
    [self.sv addSubview:iv];
    
    [self setActiveMenuBG:activeIndex];
    UIImage* signMenuImage = [UIImage imageNamed:_currentBackgroundPic];
    activeMenuImageView.image = signMenuImage;
    [self.sv addSubview:activeMenuImageView];
    
	self.sv.contentSize = CGSizeMake(numItems * buttonWidth, scrollViewHeight);
    
    for(int i = 0 ; i < numItems; i ++)
    {
        NSString *title = @"";
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(menu:titleForMenuItemAtIndex:)]) {
            title = [self.dataSource menu:self titleForMenuItemAtIndex:i];
        }
        
		UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setTitle:title forState:UIControlStateNormal];
        menuButton.titleLabel.font = buttonFont;
        menuButton.backgroundColor = [UIColor clearColor];
        
        [menuButton setTitleColor:self.normalColor forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        UIColor* borderColor = [UIColor colorWithRed:((float) 255 / 255.0f) green:((float) 0 / 255.0f) blue:((float) 0 / 255.0f) alpha:.2f];
        float borderWidth = 1;
        
        menuButton.layer.borderColor = borderColor.CGColor;
        menuButton.layer.borderWidth = borderWidth;
        [menuButton addTarget:self action:@selector(touchBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        menuButton.tag = btnTag + i;
		menuButton.frame = CGRectMake(i * buttonWidth, 0, buttonWidth , menuHeight);
        [self.sv addSubview:menuButton];
    }
    [self layoutSubviews];
    [self.sv layoutSubviews];
}

- (void) gotoSubMenuWithIndex:(NSInteger)index
{
    if (index * subMenuWidth < self.sv.contentOffset.x) {
        [self.sv setContentOffset:CGPointMake(index * subMenuWidth, 0) animated:YES];
    }
    if (index * subMenuWidth > 3 * subMenuWidth + self.sv.contentOffset.x) {
        [self.sv setContentOffset:CGPointMake((index - 3) * subMenuWidth, 0) animated:YES];
    }
    [self setActiveMenuBG:index];
}

- (IBAction)touchBtnEvent:(id)sender
{
    UIButton *currentBtn = (UIButton *)sender;
    activeIndex = currentBtn.tag - btnTag;
    
    if (self.focusMenuDelegate && [self.focusMenuDelegate respondsToSelector:@selector(menu:itemFocusedAtIndex:)]) {
        [self.focusMenuDelegate menu:self itemFocusedAtIndex:activeIndex];
    }
    
    [self setActiveMenuBG:activeIndex];
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //update active index
//    float x = self.sv.contentOffset.x;
}



@end

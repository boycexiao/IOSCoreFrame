//
//  XBShakeViewController.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-15.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBShakeViewController.h"
#import <QuartzCore/QuartzCore.h>

//默认最大晃动频率
#define XBDefault_Max_ShakeFrequency        25.0f


@interface XBShakeViewController ()

@property (nonatomic, assign) double currentMaxShakeFrequency;

@end

@implementation XBShakeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self becomeFirstResponder];
   
}

- (void)dealloc
{
    [XAppDelegate.sharedMotionManager stopAccelerometerUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Motion Events

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (XAppDelegate.sharedMotionManager.accelerometerAvailable) {
        XAppDelegate.sharedMotionManager.accelerometerUpdateInterval = 0.01;
        
        [XAppDelegate.sharedMotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            CMAccelerometerData *newestAccel = XAppDelegate.sharedMotionManager.accelerometerData;
            double shakeFrequency = fabs(newestAccel.acceleration.x) + fabs(newestAccel.acceleration.y) + fabs(newestAccel.acceleration.z);
            self.currentMaxShakeFrequency = (self.currentMaxShakeFrequency > shakeFrequency) ? self.currentMaxShakeFrequency : shakeFrequency;
        }];
    }
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        
//        self.shakePointerImageView.layer.anchorPoint = CGPointMake(0, 0);
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self.shakePointerImageView];
        [UIView animateWithDuration:3.0 animations:^{
  
            self.shakePointerImageView.transform = CGAffineTransformMakeRotation(self.currentMaxShakeFrequency * 1.0 * (M_PI) / XBDefault_Max_ShakeFrequency);

        }];
        
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end

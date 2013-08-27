//
//  AppDelegate.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-2.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//


#define XAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#import <UIKit/UIKit.h>
#import <CoreMotion/CMMotionManager.h>
#import <CoreData/CoreData.h>

@class XBHomeViewController;
@class PPRevealSideViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CMMotionManager *sharedMotionManager;


@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) XBHomeViewController *viewController;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;

@end

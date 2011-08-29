//
//  CurlViewDemoAppDelegate.h
//  CurlViewDemo
//
//  Created by Andrea Ottolina on 29/08/2011.
//  Copyright 2011 Pixelinlove ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CurlViewDemoViewController;

@interface CurlViewDemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CurlViewDemoViewController *viewController;

@end

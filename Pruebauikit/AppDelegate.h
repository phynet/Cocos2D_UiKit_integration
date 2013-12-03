//
//  AppDelegate.h
//  Pruebauikit
//
//  Created by Sofía Swidarowicz on 26/03/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "General.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    General				*general;
	NSNotificationCenter *notifyCenter;
}

@property (nonatomic, retain) NSNotificationCenter *notifyCenter;
@property (nonatomic, retain) General *general;
@property (nonatomic, retain) UIWindow *window;


- (void) showUIViewController:(UIViewController *) controller;

- (void) hideUIViewController:(UIViewController *) controller;

@end

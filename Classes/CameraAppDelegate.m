/**
 *
 * CameraAppDelegate.m
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import "CameraAppDelegate.h"
#import "CameraViewController.h"

@implementation CameraAppDelegate

@synthesize window = _window;
@synthesize _viewController;
@synthesize navigationController = _navigationController;

- (void)dealloc
{
    [_viewController release];
    [UIViewController release];
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self._viewController = [[CameraViewController alloc]
                            initWithNibName:@"CameraViewController" bundle:nil];
    self.window.rootViewController = self._viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
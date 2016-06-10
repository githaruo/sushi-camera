/**
 *
 * CameraAppDelegate.h
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import <UIKit/UIKit.h>

@class CameraViewController;

@interface CameraAppDelegate : NSObject <UIApplicationDelegate>
{
    IBOutlet UIWindow*               _window;
    IBOutlet CameraViewController*   _viewController;
}

@property (strong, nonatomic) UINavigationController* navigationController;
@property (strong, nonatomic) CameraViewController* _viewController;

@end
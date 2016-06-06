/**
 *
 * info.h
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

@interface info : UIViewController <UIWebViewDelegate,GADBannerViewDelegate>{
    IBOutlet UIWebView *webView;
    GADBannerView *bannerView_;
}

@property (nonatomic, retain) id delegate;

- (IBAction)dismissAction:(id)sender;

@end
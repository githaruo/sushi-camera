/**
 *
 * sushiSelect.h
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

@protocol sushiSelectDelegate  
- (void) updateImage:(NSString*) string;  
@end  

@interface sushiSelect : UIViewController <UIApplicationDelegate,GADBannerViewDelegate> {
    IBOutlet UITableView *myTableView;
    NSMutableArray *listOfContents;
    NSMutableArray *detailContents;    
    NSMutableArray *photoList;
    GADBannerView *bannerView_;
}

@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *listOfContents;
@property (nonatomic, retain) NSMutableArray *detailContents;
@property (nonatomic, retain) NSMutableArray *photoList;
@property (nonatomic, retain) id delegate;

@end
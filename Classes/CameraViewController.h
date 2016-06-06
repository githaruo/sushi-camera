/**
 *
 * CameraViewController.h
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <StoreKit/StoreKit.h>

@class info;
@class sushiSelect;
@class sushiTables;

@interface MyUIScrollView : UIScrollView
{
}
@end

@interface CameraViewController : UIViewController 
        <
        UIActionSheetDelegate,
        UINavigationControllerDelegate,
        UIImagePickerControllerDelegate,
        UIScrollViewDelegate
        >
{
    IBOutlet UIImageView* _backGroundImageView;
    IBOutlet UIImageView* _layerImageView;
    IBOutlet UIView* _SushiOverlayView;
    IBOutlet UIView* _ScrollSushiOverlayView;
    IBOutlet UIImageView* _adjustableLayerImageView;
    IBOutlet UIView* _help;
    IBOutlet UILabel* sushiLv;
    IBOutlet UILabel* sushiPoint;
    
    UIActivityIndicatorView *activityIndicatorView;
    NSString *cameraFlag;
    info* viewController;
}

@property (nonatomic, retain) IBOutlet UIView* _SushiOverlayView;
@property (nonatomic, retain) IBOutlet UIView* _ScrollSushiOverlayView;
@property (nonatomic, retain) IBOutlet UIView* _help;

@property (nonatomic, retain) IBOutlet UIScrollView* _scrollView;

@property (nonatomic, retain) IBOutlet UIImageView* _adjustableLayerImageView;
@property (nonatomic, retain) IBOutlet UIImageView* _backGroundImageView;
@property (nonatomic, retain) IBOutlet UIImageView* _layerImageView;

@property (nonatomic, retain) IBOutlet UILabel* sushiLv;
@property (nonatomic, retain) IBOutlet UILabel* sushiPoint;

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) NSString *cameraFlag;
@property (nonatomic, retain) info* viewController;

- (IBAction) showCameraSheet;
- (IBAction) openPhotoLibrary;
- (IBAction) saveChangedImage;

- (IBAction) openSelectWindow;
- (IBAction) openHelp;
- (IBAction) closeHelp;

@end
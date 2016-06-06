/**
 *
 * CameraViewController.m
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import "CameraViewController.h"
#import "info.h"
#import "sushiSelect.h"
#import "SHK.h"

#import <stdlib.h>
#import <math.h>

@implementation MyUIScrollView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"customTouchesBegan");
    self.superview.hidden = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"customTouchesMoved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"customTouchesEnded");
    self.superview.hidden = NO;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}

@end

@implementation CameraViewController
@synthesize _SushiOverlayView, _ScrollSushiOverlayView, _help,
    _adjustableLayerImageView, activityIndicatorView,
    _backGroundImageView, _layerImageView;
@synthesize sushiLv,sushiPoint;
@synthesize cameraFlag;
@synthesize viewController;

NSString *cameraFlag = @"";
BOOL moved_ = NO;
BOOL singleTapReady_ = NO;
BOOL pinched_ = NO;
BOOL butaFlag = NO;
BOOL donateFlag = NO;

- (void)setSUSHIPoint {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int sushipt = [defaults integerForKey:@"sushipt"];
    
    NSLog(@"sushipt before:%d", sushipt);
    int num = 3;
    int add = arc4random() % num;
    if(add == 0) add = 1;
    NSLog(@"get random: %d", add);
    
    if(sushipt == 0){
        sushipt = 1;
    } else {
        sushipt += add;
    }
    
    NSLog(@"sushipt after:%d", sushipt);    
    [defaults setInteger: sushipt forKey:@"sushipt"];
    [defaults synchronize];    
}

- (int)getSUSHIPoint {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int sushipt = [defaults integerForKey:@"sushipt"];
    return sushipt;
}

- (NSString *)getTheName:(int)sp {
    int sushilv = (floor(sp / 20)) + 1;
    NSLog(@"your sushilv is Lv%d", sushilv);    
    NSString *sushiname = @"";
    if(sushilv < 5) {
        sushiname = @"Beginner";            
    } else if (sushilv > 5 && sushilv < 15){
        sushiname = @"Newbie";   
    } else if (sushilv > 15 && sushilv < 30){
        sushiname = @"Master SUSHI";
    } else if (sushilv > 30 && sushilv < 50){
        sushiname = @"Black Belt SUSHIMAN";
    } else if (sushilv > 50 && sushilv < 75){
        sushiname = @"Wizard of SUSHI";
    } else if (sushilv > 75 && sushilv < 105){
        sushiname = @"Grand master SUSHI";
    } else if (sushilv > 105 && sushilv < 140){
        sushiname = @"Extream SUSHIMAN";
    } else if (sushilv > 140 && sushilv < 200){
        sushiname = @"Absolute SUSHI OTOKO";
    } else if (sushilv > 200){
        sushiname = @"SUSHI SHOKUNIN";
    }
    
    NSLog(@"%@ Lv%d %dpt", sushiname, sushilv, sp);
    NSString *thename= [NSString stringWithFormat:@"%@ Lv%d", sushiname, sushilv];
    
    return thename;
}

- (IBAction)shareButton:(id)sender {
    
    NSLog(@"backgroundImageView frame width:%f height:%f",
          _backGroundImageView.frame.size.width, _backGroundImageView.frame.size.height);
    NSLog(@"backgroundImageView image width:%f height:%f",
          _backGroundImageView.image.size.width, _backGroundImageView.image.size.height);
    
    sushiLv.hidden = YES;
    sushiPoint.hidden = YES;

    CGFloat scale = [[UIScreen mainScreen] scale];
    NSLog(@"scale is: %f", scale);
    CGSize  size = {
                    _backGroundImageView.frame.size.width / scale * 2,
                    _backGroundImageView.frame.size.height / scale * 2
                    };

    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self.view.layer presentationLayer] renderInContext:context];

    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	    
    int sushipt = [self getSUSHIPoint];
    NSString *sushimaster = [self getTheName:sushipt];    
    NSString *title = [NSString stringWithFormat:@"#sushicam %@", sushimaster];  
    SHKItem *item = [SHKItem image:shrinkedImage title:title];    
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
    [actionSheet showInView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *photo = [defaults stringForKey:@"photo"];

    _layerImageView.image = [UIImage imageNamed:photo];
    _adjustableLayerImageView.image = [UIImage imageNamed:photo];

    [self setSUSHIPoint];
    int sushipt = [self getSUSHIPoint];
    NSString *sushimaster = [self getTheName:sushipt];    
    sushiLv.text = sushimaster;
    sushiPoint.text = [NSString stringWithFormat:@"%dpt", sushipt];
}

- (IBAction)openSelectWindow {
    NSLog(@"openSelect");

    sushiSelect *viewControllerSelect = [[sushiSelect alloc]
                                            initWithNibName:@"sushiSelect" bundle:nil];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"over ios6");

    }
    
    [self presentViewController: viewControllerSelect animated:YES completion:
        ^{NSLog(@"completion openSelectWindow");}];
}

- (IBAction)openHelp {
    NSLog(@"openHelp");
    info *viewControllerInfo = [[info alloc] initWithNibName:@"info" bundle:nil];
    [self presentViewController: viewControllerInfo animated:YES completion:
        ^{NSLog(@"completion openHelpWindow");}];
}

- (IBAction)closeHelp {
}

- (IBAction)saveChangedImage {
    NSLog(@"saving image");
    UIImage* originalImage = _backGroundImageView.image;
    UIImage* originalImage2 = _backGroundImageView.image;
    NSLog(@"saving image _imageView:%@ _layerImageView:%@",
            _backGroundImageView.image, _layerImageView.image);
    
    CGImageRef  cgImagetmp;
    cgImagetmp = originalImage2.CGImage;

    size_t widthtmp;
    size_t heighttmp;
    widthtmp = CGImageGetWidth(cgImagetmp);
    heighttmp = CGImageGetHeight(cgImagetmp);
    
    NSLog(@"SHK widthtmp:%lu heighttmp:%lu", widthtmp, heighttmp);
	
    CGSize  size = { 320, 440 };
    UIGraphicsBeginImageContext(size);

    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = size;
    [originalImage drawInRect:rect];

    CGSize sizetmp = { _layerImageView.frame.size.width ,
            _layerImageView.frame.size.height};
    NSLog(@"transformed width:%f height:%f",
          _layerImageView.frame.size.width,
          _layerImageView.frame.size.height);

    CGRect  rect2;
    rect2.size = sizetmp;
    rect2.origin.x = _layerImageView.frame.origin.x;
    rect2.origin.y = _layerImageView.frame.origin.y;
    [originalImage2 drawInRect:rect2 blendMode:kCGBlendModeNormal alpha:1.0];
    //[originalImage2 drawAtPoint:rect2.origin blendMode:kCGBlendModeNormal alpha:1.0];
	
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageWriteToSavedPhotosAlbum(
                                   shrinkedImage,
                                   self,
                                   @selector(localSavedImage:didFinishSavingWithError:
                                             contextInfo:),
                                   NULL);
}

- (IBAction)showCameraSheet
{	
    // Check camera can allow to use from this App.
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Can't open camera"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK",nil];
        [alertView show];
        [alertView release];
        return;
    }
	
	cameraFlag = @"camera";
    UIImagePickerController* imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker autorelease];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;	
    imagePicker.cameraOverlayView = _ScrollSushiOverlayView;
    [self presentViewController: imagePicker animated:YES completion:
        ^{NSLog(@"completion openCameraview");}];
}

- (IBAction)openPhotoLibrary {
	cameraFlag = @"image";
    UIImagePickerController* imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker autorelease];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController: imagePicker animated:YES completion:
        ^{NSLog(@"completion openImagepickerview");}];
}

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Camera overlay mode
    [self dismissViewControllerAnimated:YES completion: nil];
	
	NSLog(@"%@", cameraFlag);
	
    // NSLog(@"is _adjustableLayerImageView reset? %@", _adjustableLayerImageView.image);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _adjustableLayerImageView.image = [UIImage imageNamed:
                                       [defaults stringForKey:@"photo"]];
    
    UIImage*    originalImage;
    CGSize size = {320, 440};
    
    originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIGraphicsBeginImageContext(size);
    
    CGRect  rect;
    CGRect  rect2;
    rect.origin = CGPointZero;
    rect.size = size;
    [originalImage drawInRect:rect];

    NSLog(@"_adjustableLayerImageView.frame.size.width: %f",
            _adjustableLayerImageView.frame.size.width);
    NSLog(@"_adjustableLayerImageView.image.size.width: %f",
            _adjustableLayerImageView.image.size.width);

    
    if ([cameraFlag isEqual: @"image"]) {
        float sizerate = _adjustableLayerImageView.frame.size.width /
            _adjustableLayerImageView.image.size.width;
        NSLog(@"sizerate: %f", sizerate);

        float calwidth = _adjustableLayerImageView.image.size.width * sizerate;
        float calheight = _adjustableLayerImageView.image.size.height * sizerate;
        NSLog(@"cal w:%f h:%f", calwidth, calheight);

        float diffheight =  ((calheight - _adjustableLayerImageView.frame.size.height) / 2) - 1;
        NSLog(@"diffheight %f", diffheight);

        rect2.size = CGSizeMake(calwidth * 2, calheight * 2);
        rect2.origin.x = _adjustableLayerImageView.frame.origin.x;
        rect2.origin.y = (_adjustableLayerImageView.frame.origin.y - diffheight) * 2;
    
        NSLog(@"transformed origin.x:%f origin.y:%f", rect2.origin.x, rect2.origin.y);
    }

    if ([cameraFlag isEqual: @"camera"]) {
        [_layerImageView.image drawInRect:rect2 blendMode:kCGBlendModeNormal alpha:1.0];
    }

    _backGroundImageView.image = originalImage;
    
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if ([cameraFlag isEqual: @"camera"]) {
		UIImageWriteToSavedPhotosAlbum(
                                       shrinkedImage,
                                       self,
                                       @selector(localSavedImage:didFinishSavingWithError:
                                                 contextInfo:),
                                       NULL);
	}
}

- (void)localSavedImage:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void *)contextInfo {
	[self.activityIndicatorView stopAnimating];  
		
	if(!error){
		UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Save"
                                  message:@"Save photo"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK",nil];
		[alertView show];
		[alertView release];
	}else{
		UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Save"
                                  message:@"Can't save photo"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK",nil];
		[alertView show];
		[alertView release];
	}
	cameraFlag = @"";
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
	cameraFlag = @"";
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (1 == [touches count]){
		UITouch* touch = [touches anyObject];
		CGPoint pt = [touch locationInView:self.view];
		float ptx = pt.x - 30;
		float pty = pt.y - 30;
    	
		NSLog(@"touchesBegan: %d, %d", (int)ptx, (int)pty);
		[self.view addSubview:_SushiOverlayView];
        
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         NSString *photo = [defaults stringForKey:@"photo"];
         NSLog(@"photoName:%@", photo);
        
		_layerImageView.center = CGPointMake(ptx, pty);
        
        [self setSUSHIPoint];
        int sushipt = [self getSUSHIPoint];
        NSString *sushimaster = [self getTheName:sushipt];    
        sushiLv.text = sushimaster;
        sushiPoint.text = [NSString stringWithFormat:@"%dpt", sushipt];
	}
}

- (CGFloat)distanceWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB {
	CGFloat dx = fabs( pointB.x - pointA.x );
	CGFloat dy = fabs( pointB.y - pointA.y );
	return sqrt( dx * dx + dy * dy );
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (2 == [touches count]) {
		NSArray* twoFingers = [touches allObjects];
		UITouch* touch1 = [twoFingers objectAtIndex:0];
		UITouch* touch2 = [twoFingers objectAtIndex:1];
		CGPoint previous1 = [touch1 previousLocationInView:self.view];
		CGPoint previous2 = [touch2 previousLocationInView:self.view];
		CGPoint now1 = [touch1 locationInView:self.view];
		CGPoint now2 = [touch2 locationInView:self.view];
		CGFloat previousDistance = [self distanceWithPointA:previous1 pointB:previous2];
		CGFloat distance = [self distanceWithPointA:now1 pointB:now2];		
		//NSLog(@"previousDistance distance %d %d", previousDistance, distance);
		
		CGFloat scale = 1.0;
		if (previousDistance > distance) {
			scale -= (previousDistance - distance) / 300.0;
		} else if (distance > previousDistance) {
			scale += (distance - previousDistance) / 300.0;
		} 
		
		CGAffineTransform newTransform =
		CGAffineTransformScale(_layerImageView.transform, scale, scale );
		_layerImageView.transform = newTransform;
		
		NSLog(@"pinch trans width:%f height:%f",
                _layerImageView.frame.size.width, _layerImageView.frame.size.height);
		pinched_ = YES;
	} else if (1 == [touches count] && !pinched_) {
		UITouch* touch = [touches anyObject];
		CGPoint pt = [touch locationInView:self.view];
		float ptx = pt.x - 30;
		float pty = pt.y - 30;
		
		_layerImageView.center = CGPointMake(ptx, pty);
	}
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	NSArray* twoFingers = [touches allObjects];
	UITouch* touch1  = [twoFingers objectAtIndex:0];
	// NSLog(@"ended moved: %@", moved_);
	NSInteger tapCount = [touch1 tapCount];
	if ( 2 > tapCount ) {
		NSLog(@"double touches ended");
		pinched_ = NO;
	}
}

- (void)singleTap:(NSSet*)touches {

}

@end
/**
 *
 * info.m
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import "info.h"

@import GoogleMobileAds;

@implementation info

@synthesize bannerView;
UIWebView *webView;

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView;{
    NSLog(@"get ads");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
        
    CGRect rect = [webView frame];
    rect.origin.y = 92; //44 //92
    [webView setFrame:rect];
    [UIView commitAnimations];	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSString* scheme = [[request URL] scheme];

    if([scheme compare:@"http"] == NSOrderedSame) {
        [[UIApplication sharedApplication] openURL: [request URL]];
    } else {
        return YES;
    }
    return NO;
}

- (IBAction)dismissAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    UIScrollView *scrollView = [webView.subviews objectAtIndex:0];
    scrollView.bounces = NO;
    
    bannerView = [[GADBannerView alloc]
                  initWithFrame:CGRectMake(0.0,44,
                                           GAD_SIZE_320x50.width,
                                           GAD_SIZE_320x50.height)];
    
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;

    [self.view addSubview:bannerView];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[
                            kGADSimulatorID
                            ];
    [self.bannerView loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
		
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    
    //[bannerView_ release];
    [super dealloc];
}

@end
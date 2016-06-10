/**
 *
 * sushiSelect.m
 *
 * Released under MIT License http://opensource.org/licenses/MIT
 * Copyright (c) 2016 Haruo Takamatsu
 * Refer to file LICENSE or URL above for full text
 */

#import "sushiSelect.h"
#import "CameraViewController.h"

@implementation sushiSelect

@synthesize myTableView;
@synthesize listOfContents;
@synthesize detailContents;
@synthesize photoList;
@synthesize bannerView;

- (IBAction)dismissAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView;{
    NSLog(@"get ads");
    
    //[self.view addSubview:bannerView];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    CGRect rect = [myTableView frame];
    rect.origin.y = 93; //44 //92
    [myTableView setFrame:rect];
    [UIView commitAnimations];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    } 
    
    NSArray *sushiImages =
    [NSArray arrayWithObjects:@"amaebi_side.png",
                              @"chutoro_side.png",
                              @"ebi_side.png",
                              @"ika_side.png",
                              @"ikura_side.png",
                              /* ver1.3 */
                              @"tekkamaki_top.png",
                              @"kai_side.png",
                              @"kazunoko_side.png",
                              @"saba_side.png",
                              @"sarmon_side.png",
                              @"tamago_side.png",
                              @"tekkamaki_side.png",     
                              @"uni_side.png",     
                              /*ver1.1*/
                              @"ikura_top02_min.png",     
                              @"saba_top02_min.png",     
                              @"chutoro_side02_min.png",
                              /* ver1.2*/
                              @"atsutama_naname.png",
                                nil];
    
    UIImageView *imageView;
    imageView = cell.imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage: [UIImage imageNamed: [sushiImages objectAtIndex:indexPath.row]]];
    
    // Configure the cell...
    cell.textLabel.text = [listOfContents objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [detailContents objectAtIndex:indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [bannerView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
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
       
    self.listOfContents = [[NSMutableArray alloc] initWithCapacity:12];
    [listOfContents addObject: @"Ama Ebi"];
    [listOfContents addObject: @"Akami"];
    [listOfContents addObject: @"Yude Ebi"];
    [listOfContents addObject: @"Ika"];
    [listOfContents addObject: @"Ikura"];
    [listOfContents addObject: @"Makimono"];
    [listOfContents addObject: @"Kai"];
    [listOfContents addObject: @"Kazunoko"];
    [listOfContents addObject: @"Kohada"];
    [listOfContents addObject: @"Salmon"];
    [listOfContents addObject: @"Tamago"];    
    [listOfContents addObject: @"Tekka Maki"];
    [listOfContents addObject: @"Uni"];        
    [listOfContents addObject: @"Ikura Top"];
    [listOfContents addObject: @"Kohada Whole"];
    [listOfContents addObject: @"Chu toro"];
    [listOfContents addObject: @"Atuyaki Tamago"];

    self.detailContents = [[NSMutableArray alloc] initWithCapacity:12];
    [detailContents addObject: @"Ama Ebi(Ama prawn)"];
    [detailContents addObject: @"Akami(Tuna)"];
    [detailContents addObject: @"Yude Ebi(Kuruma prawn)"];
    [detailContents addObject: @"Ika(Big fin reef squid)"];
    [detailContents addObject: @"Ikura(Ikura salmon roe)"];
    [detailContents addObject: @"Makimono(Nori-maki)"];
    [detailContents addObject: @"Kai(Scallop)"];
    [detailContents addObject: @"Kazunoko(Herring roe)"];
    [detailContents addObject: @"Kohada(Gizzard shad)"];
    [detailContents addObject: @"Salmon"];
    [detailContents addObject: @"Tamago(Chunkey omlet)"];    
    [detailContents addObject: @"Tekka Maki(Red tuna Nori-maki)"];
    [detailContents addObject: @"Uni(Sea urchin)"];
    [detailContents addObject: @"Combination Mode"];
    [detailContents addObject: @"Kohada(Gizzard shad) Whole"];
    [detailContents addObject: @"Chu Toro(Tuna middle TORO)"];
    [detailContents addObject: @"Atuyaki Tamago(Thickly Chunkey omlet)"];
    
    self.photoList = [[NSMutableArray alloc] initWithCapacity:12];
    [photoList addObject: @"amaebi_top_min03.png"];
    [photoList addObject: @"akami_side_min.png"]; //@"chutoro_side.png"
    [photoList addObject: @"ebi_side_min04.png"];
    [photoList addObject: @"ika_side_min02.png"];
    [photoList addObject: @"ikura_side_min.png"];
    [photoList addObject: @"tekkamaki_top_min.png"];
    [photoList addObject: @"kai_side_min02.png"];
    [photoList addObject: @"kazunoko_side_min03.png"];
    [photoList addObject: @"saba_side_min03.png"];
    [photoList addObject: @"sarmon_naname_min02.png"];
    [photoList addObject: @"tamago_side_min.png"];
    [photoList addObject: @"tekkamaki_side_min02.png"];
    [photoList addObject: @"uni_side_min.png"];
    [photoList addObject: @"ikura_top02_burn.png"];
    [photoList addObject: @"saba_top03.png"];
    [photoList addObject: @"chutoro_side02.png"];
    [photoList addObject: @"atsutama_naname_big.png"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *photoName = [self.photoList objectAtIndex:[indexPath row]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:photoName forKey:@"photo"];
    [defaults synchronize];
    
    NSLog(@"photoName:%@", photoName);
    [self dismissViewControllerAnimated:YES completion: nil];
    
}

@end
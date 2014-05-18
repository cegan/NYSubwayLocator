//
//  SubwayStationDetailViewController.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "SubwayStationDetailViewController.h"

@interface SubwayStationDetailViewController ()

@end

@implementation SubwayStationDetailViewController

@synthesize subwayStation                 = _subwayStation;
@synthesize currentLocation               = _currentLocation;
@synthesize subwayStationDetailsTableView = _subwayStationDetailsTableView;



#pragma mark -
#pragma mark - VC Init
#pragma mark -

- (id) initWithSubwayStation:(SubwayStation *) subwayStation currentLocation:(CLLocation *) currentLocation{
    
    self = [super initWithNibName:@"SubwayStationDetailViewController" bundle:nil];
    
    if (self) {
        
        self.subwayStation      = subwayStation;
        self.currentLocation    = currentLocation;
    }
    
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        
    }
    
    return self;
}






#pragma mark -
#pragma mark - Events
#pragma mark -

- (void) onBackButtonTouched{
    
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark -
#pragma mark - View Delegates
#pragma mark -

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [self installViewProperties];
    [self installTableViewProperties];
    [self installBackButton];
}

- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case kRouteToSubwayStation:
            [self routeUserToSubwayLocation];
            break;
        
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {

        case kDistanceToSubwayStation:
            return 50;
            break;

        case kRouteToSubwayStation:
            return 60;
            break;

        default:
            break;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"testCell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    switch (indexPath.row) {
            
        case kDistanceToSubwayStation:
            [cell.contentView addSubview:[self subwayStationNameCellView]];
            break;
            
        case kRouteToSubwayStation:
            [cell.contentView addSubview:[self distanceToSubwayStationCellView]];
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






#pragma mark -
#pragma mark - View Setup
#pragma mark -

- (void) installViewProperties{
    
    self.navigationItem.title = self.subwayStation.stationName;
}

- (void) installTableViewProperties{
    
    self.subwayStationDetailsTableView.delegate        = self;
    self.subwayStationDetailsTableView.dataSource      = self;
    self.subwayStationDetailsTableView.scrollEnabled   = NO;
}

- (void) installBackButton{
    
    UIBarButtonItem *barButtonItem  = [[UIBarButtonItem alloc] init];
    UIButton *backButton            = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame                = CGRectMake(0, 0, 18, 20);
    
    [backButton addTarget:self action:@selector(onBackButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ios_backArrow.png"] forState:UIControlStateNormal];
    [barButtonItem setCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}





#pragma mark -
#pragma mark - Utility Methods
#pragma mark -

- (NSString *) getTotalMilesToSubwayStation{
    
    CLLocation *subwayStationLocation = [[CLLocation alloc] initWithLatitude:self.subwayStation.thCoordinate.latitude
                                                                longitude:self.subwayStation.thCoordinate.longitude];
    
    CLLocation *currentLocation      = [[CLLocation alloc] initWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
    
    
    return [NSString stringWithFormat:@"%.1f Miles",([subwayStationLocation distanceFromLocation:currentLocation]/1609.344)];
}

- (void) routeUserToSubwayLocation{
    
    MKPlacemark *placeMark      = [[MKPlacemark alloc] initWithCoordinate:self.subwayStation.coordinate addressDictionary:nil];
    MKMapItem *destination      = [[MKMapItem alloc] initWithPlacemark:placeMark];
    destination.name            = self.subwayStation.stationName;
    
    [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking}];
}






#pragma mark -
#pragma mark - Custom Cell Views
#pragma mark -

- (UIView *) subwayStationNameCellView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 260, 50)];
    
    UILabel *officeNameValue   = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 200, 20)];
    officeNameValue.text       = self.subwayStation.stationName;
    officeNameValue.textColor  = DARK_GREY_TEXT_COLOR;
    
    [view addSubview:officeNameValue];
    
    return view;
}

- (UIView *) distanceToSubwayStationCellView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 260, 50)];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(245, 20, 23, 20)];
    imageView.image = [UIImage imageNamed:@"map.png"];
    
    UILabel *distanceLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
    distanceLabel.font          = HELVETICA_NEUE_14PT;
    distanceLabel.text          = @"Route to subway station";
    distanceLabel.textColor     = GRREN_TEXT_COLOR;
    
    
    UILabel *distanceValue      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 20)];
    distanceValue.text          = [self getTotalMilesToSubwayStation];
    distanceValue.textColor     = DARK_GREY_TEXT_COLOR;
    
    [view addSubview:distanceLabel];
    [view addSubview:distanceValue];
    [view addSubview:imageView];
    
    
    return view;
}





@end

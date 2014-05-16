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
            
//        case kFCSALocationPhoneNumber:
//            
//            [TelephoneUtilities placePhoneCallToNumber:self.officeLocation.phoneNumber];
//            break;
//            
//        case kFCSADistanceToLocation:
//            
//            [self openFCSAOfficeLocationInMaps];
//            break;
//            
//        case kFCSALocationAddToFavorites:
//            
//            if([self isAddressBookAccessGranted]){
//                
//                [self addFCSAOfficeAsContact:self.officeLocation];
//            }
//            break;
//            
//        default:
//            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    switch (indexPath.row) {
//            
//        case kFCSAOfficeName:
//            return 55;
//            break;
//            
//        case kFCSADistanceToLocation:
//            return 60;
//            break;
//            
//        case kFCSALocationPhoneNumber:
//            return 55;
//            break;
//            
//        case kFCSALocationAddress:
//            return 80;
//            break;
//            
//        case kFCSALocationAddToFavorites:
//            return 40;
//            break;
//            
//        case kFCSAShareLocation:
//            return 200;
//            break;
//            
//        default:
//            return 0;
//            break;
//    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"testCell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    
//    switch (indexPath.row) {
//            
//        case kFCSAOfficeName:
//            [cell.contentView addSubview:[self officeNameCellView]];
//            break;
//            
//        case kFCSADistanceToLocation:
//            [cell.contentView addSubview:[self distanceToLocationCellView]];
//            break;
//            
//        case kFCSALocationPhoneNumber:
//            [cell.contentView addSubview:[self phoneNumberCellView]];
//            break;
//            
//        case kFCSALocationAddress:
//            [cell.contentView addSubview:[self addressCellView]];
//            break;
//            
//        case kFCSALocationAddToFavorites:
//            [cell.contentView addSubview:[self addToContactsCellView]];
//            break;
//            
//        default:
//            break;
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






#pragma mark -
#pragma mark - Component Installs
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

- (NSString *) getTotalMilesToLocation{
    
    CLLocation *subwayStationLocation = [[CLLocation alloc] initWithLatitude:self.subwayStation.thCoordinate.latitude
                                                                longitude:self.subwayStation.thCoordinate.longitude];
    
    CLLocation *currentLocation      = [[CLLocation alloc] initWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
    
    
    return [NSString stringWithFormat:@"%.1f Miles",([subwayStationLocation distanceFromLocation:currentLocation]/1609.344)];
}








#pragma mark -
#pragma mark - Custom Cell Views
#pragma mark -

- (UIView *) officeNameCellView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 260, 50)];
    
    UILabel *officeNameValue   = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 200, 20)];
    officeNameValue.text       = self.subwayStation.stationName;
    officeNameValue.textColor  = DARK_GREY_TEXT_COLOR;
    
    
    [view addSubview:officeNameValue];
    
    return view;
}

- (UIView *) distanceToLocationCellView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 260, 50)];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(245, 20, 23, 20)];
    imageView.image = [UIImage imageNamed:@"map.png"];
    
    UILabel *distanceLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
    distanceLabel.font          = HELVETICA_NEUE_14PT;
    distanceLabel.text          = @"Route to location";
    distanceLabel.textColor     = GRREN_TEXT_COLOR;
    
    
    UILabel *distanceValue      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 20)];
    distanceValue.text          = [self getTotalMilesToLocation];
    distanceValue.textColor     = DARK_GREY_TEXT_COLOR;
    
    [view addSubview:distanceLabel];
    [view addSubview:distanceValue];
    [view addSubview:imageView];
    
    
    return view;
}

- (UIView *) addToContactsCellView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 260, 40)];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"Add.png"];
    
    
    UILabel *addToFavorites   = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
    addToFavorites.font       = HELVETICA_NEUE_BOLD_14PT;
    addToFavorites.text       = @"Add to Contacts";
    addToFavorites.textColor  = GRREN_TEXT_COLOR;
    
    
    [view addSubview:addToFavorites];
    [view addSubview:imageView];
    
    return view;
}




@end

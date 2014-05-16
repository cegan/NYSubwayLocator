//
//  SubwayLocatorViewController.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "SubwayLocatorViewController.h"

@interface SubwayLocatorViewController ()

@end

@implementation SubwayLocatorViewController

@synthesize isMapListViewCurrentlySelected      = _isMapListViewCurrentlySelected;
@synthesize isMapViewCurrentlySelected          = _isMapViewCurrentlySelected;

@synthesize locationManager                     = _locationManager;
@synthesize subwayStations                      = _subwayStations;
@synthesize currentlyDisplayedSubwayStations    = _currentlyDisplayedSubwayStations;
@synthesize subwayLocationsTableView            = _subwayLocationsTableView;
@synthesize mapView                             = _mapView;
@synthesize mapToolBar                          = _mapToolBar;
@synthesize currentLocationButton               = _currentLocationButton;
@synthesize mapViewButton                       = _mapViewButton;
@synthesize mapListViewButton                   = _mapListViewButton;
@synthesize searchTextField                     = _searchTextField;
@synthesize cancelSearchButton                  = _cancelSearchButton;




#pragma mark -
#pragma mark - VC Initializers
#pragma mark -

- (id) initSubwayLocatorViewController{
    
    self = [super initWithNibName:@"SubwayLocatorViewController" bundle:nil];
    
    if (self) {
        
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
#pragma mark - Notifications
#pragma mark -

- (void) registerNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRetrievingSubwayStations:) name:kDidFinishRetrievingSubwayData object:nil];
}

- (void) didFinishRetrievingSubwayStations:(NSNotification *)notification{
    
    self.subwayStations = [[notification userInfo] valueForKey:@"Everything"];
    
    [self stopActivityIndicator];
    [self displaySubwayStationAnnotations:self.subwayStations];
}







#pragma mark -
#pragma mark - Events
#pragma mark -

- (void) searchFieldFinished:(id)sender{
    
    [sender resignFirstResponder];
    
    self.currentlyDisplayedSubwayStations = [self getSubwayStationsBySearchText:self.searchTextField.text];;
    
    if(self.currentlyDisplayedSubwayStations.count <= 0){
        
        [self displayNoResultsFoundMessage];
    }
    else{
        
        [self displaySubwayStationAnnotations:self.currentlyDisplayedSubwayStations];
        [self.subwayLocationsTableView reloadData];
    }
}

- (void) onSearchButtonTouched{
    
    [self transitionToSearchMode];
}

- (void) onCancelSearchButtonTouched{
    
    [self transitionOutOfSearchMode];
}

- (void) onCurrentLocationButtonTouched{
    
    [self centerMapOnMyLocation:self.locationManager.location];
}

- (void) onListViewButtonTouched{
    
    [self transitionToListViewOfSubwayStations];
}

- (void) onMapViewButtonTouched{
    
    [self transitionToMapViewOfSubwayStations];
}





#pragma mark -
#pragma mark - Transitioning
#pragma mark -

- (void) transitionOutOfSearchMode{
    
    self.searchTextField.text = @"";
    
    [UIView animateWithDuration:0.15f animations:^{
        
        self.searchTextField.frame = CGRectMake(235, 5, 0, 30);
    }
                     completion:^ (BOOL finished){
                         
                         [self dismissKeyBoard];
                         self.title = kSubwayLocator;
                         [self installLocationSearchButton];
                        
                     }];
}

- (void) transitionToSearchMode{
    
    self.title = @"";
    
    self.searchTextField.frame = CGRectMake(235, 5, 0, 30);
    
    [self.navigationController.navigationBar addSubview:self.searchTextField];
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.searchTextField.frame = CGRectMake(5, 5, 235, 30);
    }
                     completion:^ (BOOL finished){
                         
                         [self installCancelSearchButton];
                     }];
}

- (void) transitionToMapViewOfSubwayStations{
    
    self.mapView.hidden                     = NO;
    self.currentLocationButton.enabled      = YES;
    self.subwayLocationsTableView.hidden    = YES;
    
    [self updateSelectedToolbarItem];
}

- (void) transitionToListViewOfSubwayStations{
    
    self.mapView.hidden                  = YES;
    self.currentLocationButton.enabled   = NO;
    self.subwayLocationsTableView.hidden = NO;
    
    [self installSubwayStationsTableView ];
    [self updateSelectedToolbarItem];
}






#pragma mark -
#pragma mark - Subway Stations TableView Delegates
#pragma mark -

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self displayDetailViewForSubwayStation:[self.subwayStations objectAtIndex:indexPath.row]];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.currentlyDisplayedSubwayStations.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubwayStation *station           = [self.subwayStations objectAtIndex:indexPath.row];
    SubwayStationTableViewCell *cell = (SubwayStationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SubwayStationTableCellIdentifier"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubwayStationTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell bindSubwayStationDetail:station.stationName
                  nextArrivalTime:[self getNextArrivalTimeForSubwayStation:station]
                distanceToStation:[self getTotalMilesToSubwayLocation:station]];

    

    return cell;
}







#pragma mark -
#pragma mark - Subway Stations Map Delegates
#pragma mark -

- (MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[SubwayStation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
        
        if (annotationView == nil) {
            
            annotationView                           = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"];
            annotationView.image                     = [UIImage imageNamed:@"fcsaMarker.png"];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.tintColor                 = NAVIGATION_BAR_TINT_COLOR;
            annotationView.enabled                   = YES;
            annotationView.canShowCallout            = YES;
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void) mapView:(MKMapView *) mapView didAddAnnotationViews:(NSArray *)views {
    
    for (MKAnnotationView *anotationView in views) {
        
        CGRect endFrame = anotationView.frame;
        
        anotationView.frame = CGRectMake(anotationView.frame.origin.x, anotationView.frame.origin.y - 230.0, anotationView.frame.size.width, anotationView.frame.size.height);
        
        [UIView animateWithDuration:0.45f delay:0.30f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [anotationView setFrame:endFrame];
        }
                         completion:^ (BOOL finished){
                             
                             
                             
                         }];
    }
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    if ([view.annotation isKindOfClass:[SubwayStation class]]) {
        
        [self transitionOutOfSearchMode];
        [self displayDetailViewForSubwayStation:(SubwayStation *)view.annotation];
    }
}





#pragma mark -
#pragma mark - View Delegates
#pragma mark -

- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self registerNotifications];
    [self installViewProperties];
    [self installMapViewProperties];
    [self installLocationManager];
    [self installLocationSearchButton];
    [self installLocationSearchField];
    [self installSubwayStationsTableView];
    [self installMapToolbar];
  
    self.subwayLocationsTableView.hidden = YES;
    
    [self startActivityIndicator];
    
    [[[SubwayLocatorService alloc] init] retrieveSubwayStations];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self installViewProperties];
    [self.locationManager startUpdatingLocation];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self dismissKeyBoard];
    [super touchesBegan:touches withEvent:event];
}





#pragma mark -
#pragma mark - Setup & Installs
#pragma mark -

- (void) installViewProperties{
    
    self.title = kSubwayLocator;
    self.navigationController.navigationBar.translucent     = NO;
    self.navigationController.navigationBar.barTintColor = NAVIGATION_BAR_TINT_COLOR;
}

- (void) installMapViewProperties{
    
    self.mapView.showsUserLocation  = YES;
    self.mapView.delegate           = self;
}

- (void) installLocationManager{
    
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter     = 10;
}

- (void) installMapToolbar{
    
    self.mapToolBar         = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 460, 320, 44)];
    self.mapToolBar.items   = [self getToolBarItems];
    
    [self.view addSubview:self.mapToolBar];
}

- (void) installSubwayStationsTableView{
    
    [self.subwayLocationsTableView removeFromSuperview];
    
    self.subwayLocationsTableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.subwayLocationsTableView.backgroundColor      = [UIColor whiteColor];
    self.subwayLocationsTableView.separatorColor       = LIGHT_GREY_TABLE_SEPERATOR_COLOR;
    self.subwayLocationsTableView.delegate             = self;
    self.subwayLocationsTableView.dataSource           = self;
    self.subwayLocationsTableView.scrollEnabled        = YES;
 
    
    [self.view addSubview:self.subwayLocationsTableView];
    [self.subwayLocationsTableView reloadData];
}

- (void) installLocationSearchButton{
    
    UIBarButtonItem *barButtonItem  = [[UIBarButtonItem alloc] init];
    UIButton *searchButton          = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame              = CGRectMake(0, 0, 19, 19);
    
    [searchButton addTarget:self action:@selector(onSearchButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [barButtonItem setCustomView:searchButton];
    
    self.navigationItem.rightBarButtonItem  = barButtonItem;
}

- (void) installLocationSearchField{
    
    self.searchTextField                            = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 235, 30)];
    self.searchTextField.autoresizingMask           = UIViewAutoresizingFlexibleWidth;
    self.searchTextField.borderStyle                = UITextBorderStyleRoundedRect;
    self.searchTextField.placeholder                = @"Station Name";
    self.searchTextField.textColor                  = [UIColor colorWithRed:85.0/255.0 green:85.0/255.00 blue:85.0/255.00 alpha:0.5];
    self.searchTextField.alpha                      = 0.6f;
    self.searchTextField.delegate                   = self;
    self.searchTextField.keyboardType               = UIKeyboardTypeDefault;
    self.searchTextField.returnKeyType              = UIReturnKeySearch;
    self.searchTextField.font                       = [UIFont systemFontOfSize:14];
    self.searchTextField.clearButtonMode            = UITextFieldViewModeWhileEditing;
    self.searchTextField.autocorrectionType         = UITextAutocorrectionTypeNo;
    self.searchTextField.leftViewMode               = UITextFieldViewModeAlways;
    
    [self.searchTextField addTarget:self action:@selector(searchFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void) installCancelSearchButton{
    
    
    UIBarButtonItem *cancelSearchButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(onCancelSearchButtonTouched)];
    
    cancelSearchButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem           = cancelSearchButton;
    
}






#pragma mark -
#pragma mark - Map Methods
#pragma mark -

- (void) centerMapOnMyLocation:(CLLocation *) location{
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    region.center                   = location.coordinate;
    span.latitudeDelta              = 10;
    span.longitudeDelta             = 10;
    region.span                     = span;
    
    [self.mapView setRegion:region animated:YES];
}






#pragma mark -
#pragma mark - ToolBar Items
#pragma mark -

- (NSArray *) getToolBarItems{
    
    return [NSArray arrayWithObjects:
            [self getFixedWithItemWithWidth:-10.0f],
            [self getCurrentLocationButtonItem],
            [self getFixedWithItemWithWidth:190.0f],
            [self getMapListViewButtonItem],
            [self getMapViewButtonItem], nil];
}

- (UIBarButtonItem *) getFixedWithItemWithWidth:(CGFloat) width{
    
    UIBarButtonItem* fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = width;
    
    return fixedItem;
}

- (UIBarButtonItem *) getCurrentLocationButtonItem{
    
    self.currentLocationButton          = [UIButton buttonWithType:UIButtonTypeCustom];
    self.currentLocationButton.frame    = CGRectMake(0, 5, 28, 28);
    [self.currentLocationButton setBackgroundImage:[UIImage imageNamed:@"currentLocation.png"] forState:UIControlStateNormal];
    [self.currentLocationButton addTarget:self action:@selector(onCurrentLocationButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:self.currentLocationButton];
}

- (UIBarButtonItem *) getMapViewButtonItem{
    
    self.mapViewButton                    = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mapViewButton.frame              = CGRectMake(0, 0, 32.5, 32.5);
    [self.mapViewButton setBackgroundImage:[UIImage imageNamed:@"selectedMapBarbuttonItem.png"] forState:UIControlStateNormal];
    [self.mapViewButton addTarget:self action:@selector(onMapViewButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:self.mapViewButton];
}

- (UIBarButtonItem *) getMapListViewButtonItem{
    
    self.mapListViewButton            = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mapListViewButton.frame      = CGRectMake(0, 0, 32.5, 32.5);
    [self.mapListViewButton  setBackgroundImage:[UIImage imageNamed:@"unselectedMapListBarbuttonItem.png"] forState:UIControlStateNormal];
    [self.mapListViewButton  addTarget:self action:@selector(onListViewButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:self.mapListViewButton];
}





#pragma mark -
#pragma mark - User Messages
#pragma mark -

- (void) displayNoResultsFoundMessage{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                   message:@"No Results Found"
                                                  delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil, nil];
    
    
    
    [alert show];
    
    
}





#pragma mark -
#pragma mark - Utilities
#pragma mark -

- (NSString *) getNextArrivalTimeForSubwayStation:(SubwayStation *) subwayStation{
    
    return  [NSString stringWithFormat:@"%@%@", @"Next Arrival @ ", [subwayStation.arrivalTimes objectAtIndex:0]];
}

- (NSString *) getTotalMilesToSubwayLocation:(SubwayStation *) subwayStation{
    
    CLLocation *subwayStationLocation = [[CLLocation alloc] initWithLatitude:subwayStation.thCoordinate.latitude
                                                                   longitude:subwayStation.thCoordinate.longitude];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    
    
    return [NSString stringWithFormat:@"%.1f Miles",([subwayStationLocation distanceFromLocation:currentLocation]/1609.344)];
}

- (NSArray *) getSubwayStationsBySearchText:(NSString *) searchText{
    
    return [self.subwayStations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(stationName like[cd] %@)",searchText]];
}

- (NSArray *) sortSubwayStationsByDistance:(NSArray *) subwayStationsToSort{
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distanceToSubwayStation" ascending:YES];
    NSArray *sortDescriptors         = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [subwayStationsToSort sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}







#pragma mark -
#pragma mark - Misc
#pragma mark -

- (void) setMapViewButtonItemAsSelected:(BOOL) selected{
    
    self.isMapViewCurrentlySelected = selected;
    
    if(selected){
        
        [self.mapViewButton setBackgroundImage:[UIImage imageNamed:@"selectedMapBarbuttonItem.png"] forState:UIControlStateNormal];
    }
    else{
        
        [self.mapViewButton setBackgroundImage:[UIImage imageNamed:@"unselectedMapBarbuttonItem.png"] forState:UIControlStateNormal];
    }

}

- (void) setMapListViewButtonItemAsSelected:(BOOL) selected{
    
    self.isMapListViewCurrentlySelected = selected;
    
    if(selected){
        
        [self.mapListViewButton setBackgroundImage:[UIImage imageNamed:@"selectedMapListBarbuttonItem.png"] forState:UIControlStateNormal];
    }
    else{
        
        [self.mapListViewButton setBackgroundImage:[UIImage imageNamed:@"unselectedMapListBarbuttonItem.png"] forState:UIControlStateNormal];
        
    }
}

- (void) updateSelectedToolbarItem{
    
    if(self.isMapViewCurrentlySelected){
        
        [self setMapViewButtonItemAsSelected:NO];
        [self setMapListViewButtonItemAsSelected:YES];
    }
    else{
        
        [self setMapViewButtonItemAsSelected:YES];
        [self setMapListViewButtonItemAsSelected:NO];
    }
}

- (void) displaySubwayStationAnnotations:(NSArray *) subwayStationsToDisplay{
    
    [self removeAllSubwayStations];
    
    self.currentlyDisplayedSubwayStations = subwayStationsToDisplay;
    
    for (SubwayStation* subwayStation in subwayStationsToDisplay){
        
        [self.mapView addAnnotation:subwayStation];
    }
}

- (void) displayDetailViewForSubwayStation:(SubwayStation *) subwayStation{
    
    [self.navigationController pushViewController:[[SubwayStationDetailViewController alloc] initWithSubwayStation:subwayStation
                                                                                                   currentLocation:self.locationManager.location] animated:YES];
}

- (void) dismissKeyBoard{
    
    [self.searchTextField resignFirstResponder];
}

- (void) removeAllSubwayStations{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void) startActivityIndicator{
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading" width:60];
}

- (void) stopActivityIndicator{
    
    [DejalBezelActivityView removeViewAnimated:YES];
}

@end

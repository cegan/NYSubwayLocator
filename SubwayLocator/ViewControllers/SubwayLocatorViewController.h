//
//  SubwayLocatorViewController.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DejalActivityView.h"
#import "SubwayStationDetailViewController.h"
#import "SubwayLocatorService.h"


@interface SubwayLocatorViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>



- (id) initSubwayLocatorViewController;

@property (nonatomic, assign) BOOL                      isMapViewCurrentlySelected;
@property (nonatomic, assign) BOOL                      isMapListViewCurrentlySelected;


@property (nonatomic, retain) NSMutableArray            *subwayStations;
@property (nonatomic, retain) NSArray                   *currentlyDisplayedSubwayStations;
@property (weak, nonatomic) IBOutlet MKMapView          *mapView;
@property (nonatomic, retain) UITableView               *subwayLocationsTableView;
@property (nonatomic, retain) UIToolbar                 *mapToolBar;
@property (nonatomic, retain) UIButton                  *currentLocationButton;
@property (nonatomic, retain) UIButton                  *mapViewButton;
@property (nonatomic, retain) UIButton                  *mapListViewButton;


@property (nonatomic, retain) UITextField               *searchTextField;
@property (nonatomic, retain) UIButton                  *cancelSearchButton;

@property (retain, nonatomic) CLLocationManager         *locationManager;


@end

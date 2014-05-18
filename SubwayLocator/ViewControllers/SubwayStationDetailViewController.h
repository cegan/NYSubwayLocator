//
//  SubwayStationDetailViewController.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubwayStation.h"
#import "SubwayStationTableViewCell.h"
#import "constants.h"
#import "Enums.h"

@interface SubwayStationDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *subwayStationDetailsTableView;
@property (nonatomic, retain) SubwayStation      *subwayStation;
@property (nonatomic, retain) CLLocation         *currentLocation;


- (id) initWithSubwayStation:(SubwayStation *) subwayStation currentLocation:(CLLocation *) currentLocation;

@end

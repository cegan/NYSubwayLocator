//
//  SubwayStationTableViewCell.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubwayStation.h"

@interface SubwayStationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceToStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextArrivalTimeLabel;


- (void) bindSubwayStationDetail:(NSString *) stationName nextArrivalTime:(NSString *) nextarrivalTime distanceToStation:(NSString *) distance;


@end

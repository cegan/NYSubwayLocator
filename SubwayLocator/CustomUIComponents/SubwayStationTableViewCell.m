//
//  SubwayStationTableViewCell.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "SubwayStationTableViewCell.h"

@implementation SubwayStationTableViewCell


@synthesize distanceToStationLabel  = _distanceToStationLabel;
@synthesize stationNameLabel        = _stationNameLabel;
@synthesize nextArrivalTimeLabel    = _nextArrivalTimeLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
       
    }
    
    return self;
}

- (void)awakeFromNib{
    
    
}

- (void) bindSubwayStationDetail:(NSString *) stationName nextArrivalTime:(NSString *) nextarrivalTime distanceToStation:(NSString *) distanceToStation{
    
    self.stationNameLabel.text          = stationName;
    self.distanceToStationLabel.text    = distanceToStation;
    self.nextArrivalTimeLabel.text      = nextarrivalTime;
    self.nextArrivalTimeLabel.textColor = [UIColor whiteColor];
    
    
    self.nextArrivalTimeLabel.layer.masksToBounds       = YES;
    self.nextArrivalTimeLabel.layer.borderWidth         = 0.5;
    self.nextArrivalTimeLabel.layer.cornerRadius        = 3.0;
    self.nextArrivalTimeLabel.layer.borderColor         = [UIColor colorWithRed:108.0/255.0 green:177.0/255.0 blue:110.0/255.0 alpha:0.5].CGColor;
    self.nextArrivalTimeLabel.backgroundColor           = [UIColor colorWithRed:108.0/255.0 green:177.0/255.0 blue:110.0/255.0 alpha:0.5];
    
    
    self.accessoryType                  = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle                 = UITableViewCellSelectionStyleNone;
    
    
}

@end

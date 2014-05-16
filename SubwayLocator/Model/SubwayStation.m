//
//  SubwayStation.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "SubwayStation.h"

@implementation SubwayStation


@synthesize stationId           = _stationId;
@synthesize stationName         = _stationName;
@synthesize distanceToOffice    = _distanceToOffice;
@synthesize arrivalTimes        = _arrivalTimes;


- (MKMapItem*) mapItem{
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    
    MKMapItem *mapItem  = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name        = self.title;
    
    return mapItem;
}

- (NSString *) title {
    
    return self.stationName;
}

- (NSString *) subtitle {
    
    return [NSString stringWithFormat:@"%@%@", @"Next Arrival @ ", [self.arrivalTimes objectAtIndex:0]];
}

- (CLLocationCoordinate2D) coordinate {
    
    return self.thCoordinate;
}


@end

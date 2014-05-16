//
//  DataUtilities.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "DataUtilities.h"

@implementation DataUtilities



+ (SubwayStation *) getSubwayStationFromJsonObject:(NSDictionary *) jsonObject{
    
    SubwayStation *subwayStation = [[SubwayStation alloc] init];
    
    subwayStation.stationId      = [jsonObject objectForKey:@"id"];
    subwayStation.stationName    = [jsonObject objectForKey:@"name"];
    
    return subwayStation;
}


+ (CLLocationCoordinate2D) getSubwayStationLocationFromJsonObject:(NSDictionary *) jsonObject{
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude   = [[jsonObject objectForKey:@"lat"] doubleValue];
    coordinate.longitude  = [[jsonObject objectForKey:@"lon"] doubleValue];
    
    return coordinate;
}

@end

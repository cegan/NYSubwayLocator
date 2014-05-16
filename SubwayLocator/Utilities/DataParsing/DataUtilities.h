//
//  DataUtilities.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/15/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubwayStation.h"

@interface DataUtilities : NSObject


+ (SubwayStation *) getSubwayStationFromJsonObject:(NSDictionary *) jsonObject;

+ (CLLocationCoordinate2D) getSubwayStationLocationFromJsonObject:(NSDictionary *) jsonObject;

@end

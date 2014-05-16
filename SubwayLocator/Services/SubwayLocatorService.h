//
//  SubwayLocatorService.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "DataUtilities.h"
#import "NotificationUtilities.h"
#import "constants.h"
#import "SubwayStation.h"

@interface SubwayLocatorService : NSObject


@property (nonatomic, retain) NSMutableArray *subwayStations;

- (void) retrieveSubwayStations;

@end

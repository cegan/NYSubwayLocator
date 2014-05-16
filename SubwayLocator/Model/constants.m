//
//  constants.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "constants.h"

@implementation constants


//Notifications
NSString *const kUnexpectedError        = @"unexpectError";



//HTTP Methods
NSString *const kHttpMethodPost         = @"POST";
NSString *const kHttpMethodGet          = @"GET";


//Endpoints
NSString *const kSubwayBaseEndPoint     = @"http://mtaapi.herokuapp.com";
NSString *const kSubwayStops            = @"stop";
NSString *const kSubwayArrivalTimes     = @"api";
NSString *const kSubwayStations         = @"stations";



//Notifications
NSString *const kDidFinishRetrievingSubwayData              = @"didFinishRetrievingSubwayData";
NSString *const kDidFinishRetrievingSubwayStations          = @"didFinishRetrievingSubwayStations";
NSString *const kDidFinishRetrievingSubwayStops             = @"didFinishRetrievingSubwayStops";
NSString *const kDidFinishRetrievingSubwayArrivalTimes      = @"didFinishRetrievingSubwayArrivalTimes";


//VC Titles
NSString *const kSubwayLocator                              = @"NY Subway Locator";

@end

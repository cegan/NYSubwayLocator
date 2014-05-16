//
//  SubwayLocatorService.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import "SubwayLocatorService.h"

@implementation SubwayLocatorService

@synthesize subwayStations;



#pragma -
#pragma mark Init Methods
#pragma -

- (id) init{
    
    self.subwayStations = [[NSMutableArray alloc] init];
    
    return self;
}




#pragma -
#pragma mark Service Methods
#pragma -

- (void) retrieveSubwayStations{
    
    AFHTTPRequestOperation *operation = [self getSubwayStationsOperation];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        
        NSDictionary *jsonResponseData = [NSJSONSerialization JSONObjectWithData: response options:NSJSONReadingMutableContainers error:nil];
        
        if(jsonResponseData){
            
            NSDictionary *stationList = [jsonResponseData objectForKey:@"result"];
            
            for (NSDictionary *station in stationList) {
                
                [self.subwayStations addObject:[DataUtilities getSubwayStationFromJsonObject:station]];
            }
            
            [self retrieveStopLocationForAllStations:self.subwayStations];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [NotificationUtilities postNotification:kUnexpectedError];
    }];
    
    
    [operation start];
}

- (void) retrieveStopLocationForAllStations:(NSMutableArray *) stations{
    

    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];
 
    for (SubwayStation *subwayStation in stations) {
        
        [operationsArray addObject:[self getStopForSubwayStationOperation:subwayStation]];
    }
    
    [[self getHttpClient] enqueueBatchOfHTTPRequestOperations:operationsArray
     
                              progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                  
                                  
                              }
                              completionBlock:^(NSArray *operations) {
                                  
                                  [self retrieveArrivalTimesForAllStations:self.subwayStations];
                                  
                              }];
    
}

- (void) retrieveArrivalTimesForAllStations:(NSMutableArray *) stations{
    
    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];
    
    for (SubwayStation *station in stations) {
        
        [operationsArray addObject:[self getSubwayArrivalTimeForStationIdOperation:station]];
    }
    
    [[self getHttpClient] enqueueBatchOfHTTPRequestOperations:operationsArray
     
                                            progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                                    
                                                    
                                            }
                                            completionBlock:^(NSArray *operations) {
                                                  
                                                  [NotificationUtilities postNotification:kDidFinishRetrievingSubwayData withData:self.subwayStations keyForData:@"Everything"];
                                            }];
    
}







#pragma -
#pragma mark Service Helpers
#pragma -

- (AFHTTPClient *) getHttpClient{
    
    return [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kSubwayBaseEndPoint]];
}

- (AFHTTPRequestOperation *) getSubwayStationsOperation{
    
    return [[AFHTTPRequestOperation alloc] initWithRequest:[self getUrlRequestForEndpoint:kSubwayStations withParamaters:nil httpMethod:kHttpMethodGet]];
}

- (AFHTTPRequestOperation *) getStopForSubwayStationOperation:(SubwayStation *) subwayStation{
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self getUrlRequestForEndpoint:kSubwayStops
                                                                                                        withParamaters:@{@"id":subwayStation.stationId}
                                                                                                            httpMethod:kHttpMethodGet]];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        
        NSDictionary *jsonResponseData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        
        if(jsonResponseData){
        
            subwayStation.thCoordinate = [DataUtilities getSubwayStationLocationFromJsonObject:[jsonResponseData objectForKey:@"result"]];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
        
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *) getSubwayArrivalTimeForStationIdOperation:(SubwayStation *) subwayStation{
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self getUrlRequestForEndpoint:kSubwayArrivalTimes
                                                                                                        withParamaters:@{@"id":subwayStation.stationId}
                                                                                                            httpMethod:kHttpMethodGet]];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        
        NSDictionary *jsonResponseData = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        
        if(jsonResponseData){
            
            NSDictionary *results = [jsonResponseData objectForKey:@"result"];
            
            subwayStation.arrivalTimes = [results objectForKey:@"arrivals"];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         
    }];
    
    return operation;
}

- (NSMutableURLRequest *) getUrlRequestForEndpoint:(NSString *) endpoint withParamaters:(NSDictionary *)parameters httpMethod:(NSString *) httpMethod{
    
    return [[self getHttpClient] requestWithMethod:httpMethod path:endpoint parameters:parameters];
}


@end

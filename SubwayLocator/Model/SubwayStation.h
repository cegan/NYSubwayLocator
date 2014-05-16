//
//  SubwayStation.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SubwayStation : NSObject <MKAnnotation>


@property (nonatomic,copy) NSString         *stationId;
@property (nonatomic,copy) NSString         *stationName;
@property (nonatomic,copy) NSString         *distanceToOffice;
@property (nonatomic,copy) NSMutableArray   *arrivalTimes;


@property (nonatomic, assign) CLLocationCoordinate2D thCoordinate;


- (MKMapItem*) mapItem;


@end

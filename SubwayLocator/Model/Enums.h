//
//  Enums.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/18/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enums : NSObject




/*** This enum is used to identify the detail fields ***/
enum {
    
    kDistanceToSubwayStation     = 0,
    kRouteToSubwayStation        = 1,
};

typedef NSInteger SubwayStationDetail;



@end

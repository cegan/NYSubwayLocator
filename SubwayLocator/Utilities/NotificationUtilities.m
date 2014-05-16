//
//  NotificationUtilities.m
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//


#import "NotificationUtilities.h"

@implementation NotificationUtilities



+ (void) postNotification:(NSString *) notification withData:(id) data keyForData:(NSString *) keyForData{
    
    if(data){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:[NSDictionary dictionaryWithObject:data forKey:keyForData]];
    }
}


+ (void) postNotification:(NSString *) notification{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:nil];
}

@end

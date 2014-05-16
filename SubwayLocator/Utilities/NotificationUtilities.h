//
//  NotificationUtilities.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NotificationUtilities : NSObject



+ (void) postNotification:(NSString *) notification withData:(id) data keyForData:(NSString *) keyForData;
+ (void) postNotification:(NSString *) notification;

@end

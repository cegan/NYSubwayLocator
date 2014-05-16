//
//  constants.h
//  SubwayLocator
//
//  Created by Casey Egan  on 5/14/14.
//  Copyright (c) 2014 Casey Egan . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface constants : NSObject



//Notifications
extern NSString *const kUnexpectedError;


//HTTP Methods
extern NSString *const kHttpMethodPost;
extern NSString *const kHttpMethodGet;


//Endpoints
extern NSString *const kSubwayBaseEndPoint;
extern NSString *const kSubwayStops;
extern NSString *const kSubwayArrivalTimes;
extern NSString *const kSubwayStations;



//Notifications
extern NSString *const kDidFinishRetrievingSubwayData;
extern NSString *const kDidFinishRetrievingSubwayStations;
extern NSString *const kDidFinishRetrievingSubwayStops;
extern NSString *const kDidFinishRetrievingSubwayArrivalTimes;


//VC Titles
extern NSString *const kSubwayLocator;



//Fonts
#define HELVETICA_NEUE_10PT                     [[UIFont fontWithName:@"HelveticaNeue" size:10] init];
#define HELVETICA_NEUE_12PT                     [[UIFont fontWithName:@"HelveticaNeue" size:12] init];
#define HELVETICA_NEUE_14PT                     [[UIFont fontWithName:@"HelveticaNeue" size:14] init];
#define HELVETICA_NEUE_15PT                     [[UIFont fontWithName:@"HelveticaNeue" size:15] init];
#define HELVETICA_NEUE_16PT                     [[UIFont fontWithName:@"HelveticaNeue" size:16] init];
#define HELVETICA_NEUE_18PT                     [[UIFont fontWithName:@"HelveticaNeue" size:18] init];
#define HELVETICA_NEUE_BOLD_14PT                [[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init];
#define HELVETICA_NEUE_BOLD_12PT                [[UIFont fontWithName:@"HelveticaNeue-Bold" size:12] init];
#define HELVETICA_NEUE_BOLD_16PT                [[UIFont fontWithName:@"HelveticaNeue-Bold" size:16] init];
#define HELVETICA_NEUE_BOLD_17PT                [[UIFont fontWithName:@"HelveticaNeue-Bold" size:17] init];
#define HELVETICA_NEUE_BOLD_18PT                [[UIFont fontWithName:@"HelveticaNeue-Bold" size:18] init];
#define HELVETICA_NEUE_ITALIC_14PT              [[UIFont fontWithName:@"HelveticaNeue-Italic" size:14] init];


//Text Colors
#define LIGHT_GREY_TEXT_COLOR                   [UIColor colorWithRed:127.0/255.0 green:127.0/255.00 blue:127.0/255.00 alpha:1.0];
#define DARK_GREY_TEXT_COLOR                    [UIColor colorWithRed:66.0/255.0 green:66.0/255.00 blue:66.0/255.00 alpha:1.0];
#define MENU_ITEM_NOT_SELECTED_TEXT_COLOR       [UIColor colorWithRed:153.0/255.0 green:153.0/255.00 blue:153.0/255.00 alpha:1.0];
#define MENU_ITEM_SELECTED_TEXT_COLOR           [UIColor colorWithRed:255.0/255.0 green:255.0/255.00 blue:255.0/255.00 alpha:1.0];
#define ACCOUNT_BADGE_TEXT_COLOR                [UIColor colorWithRed:204.0/255.0 green:204.0/255.00 blue:204.0/255.00 alpha:1.0];
#define GRREN_TEXT_COLOR                        [UIColor colorWithRed:107.0/255.0 green:177.0/255.00 blue:110.0/255.00 alpha:1.0];
#define LIGHT_GRAY_TEXT_COLOR                   [UIColor colorWithRed:110.0/255.0 green:110.0/255.00 blue:110.0/255.00 alpha:1.0];


//Border Colors
#define LIGHT_GREY_TABLE_SEPERATOR_COLOR        [UIColor colorWithRed:127.0/255.0 green:127.0/255.00 blue:127.0/255.00 alpha:0.2];




#define NAVIGATION_BAR_TINT_COLOR  [UIColor colorWithRed:108.0/255.0 green:177.0/255.0 blue:110.0/255.0 alpha:1];


@end

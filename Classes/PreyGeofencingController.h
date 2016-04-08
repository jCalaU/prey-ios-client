//
//  PreyGeofencingController.h
//  Prey
//
//  Created by Carlos Yaconi on 06-12-12.
//  Copyright (c) 2012 Fork Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreyGeofencingController : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *geofencingManager;

+ (PreyGeofencingController *)instance;
- (void)addNewregion:(CLRegion *)region;
- (void)removeRegion:(NSString *)id;

@end



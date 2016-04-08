//
//  DeviceMapController.h
//  Prey
//
//  Created by Diego Torres on 3/9/12.
//  Copyright (c) 2012 Fork Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "GAITrackedViewController.h"
#import "MBProgressHUD.h"

@interface DeviceMapController : GAITrackedViewController <MKMapViewDelegate> {
    MKMapView *mapa;
    CLLocationManager * MANG;
    MBProgressHUD *HUD;
    BOOL canUpdateUserLoc;
}

@property (nonatomic) MKMapView *mapa;
@property (nonatomic) CLLocationManager * MANG;
@property (nonatomic) BOOL canUpdateUserLoc;

- (void)goToUserLocation;

@end

//
//  LocationMapViewController.h
//  MyLocationDemo
//
//  Created by User on 12/22/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface LocationMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)selectView:(id)sender;

@end

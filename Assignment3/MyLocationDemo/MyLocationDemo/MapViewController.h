//
//  MapViewController.h
//  MyLocationDemo
//
//  Created by User on 12/20/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)getAtms:(id)sender;
- (IBAction)details:(id)sender;

@end

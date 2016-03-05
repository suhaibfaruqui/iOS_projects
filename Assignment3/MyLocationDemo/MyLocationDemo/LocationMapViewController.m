//
//  LocationMapViewController.m
//  MyLocationDemo
//
//  Created by User on 12/22/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()

@end

@implementation LocationMapViewController {
    CLLocationManager *locationManager;

}
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    //[locationManager startUpdatingLocation];
    //mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    //[mapView startUpdatingLocation];
    [locationManager startUpdatingLocation];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectView:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 2) {
        //toggle the correct view to be visible
        [mapView setMapType:MKMapTypeSatellite];
    }
    if(selectedSegment == 1) {
        //toggle the correct view to be visible
        [mapView setMapType:MKMapTypeHybrid];
    }
    if(selectedSegment == 0) {
        //toggle the correct view to be visible
        [mapView setMapType:MKMapTypeStandard];
    }

}
@end

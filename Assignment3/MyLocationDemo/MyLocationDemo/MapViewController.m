//
//  MapViewController.m
//  MyLocationDemo
//
//  Created by User on 12/20/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "MapViewController.h"
#import "MyCustomAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize mapView;


- (void)viewDidLoad {
    [super viewDidLoad];
    //CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //[locationManager requestWhenInUseAuthorization];
    geocoder = [[CLGeocoder alloc] init];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(28.549787,77.301316);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coor, 200, 200);
    MyCustomAnnotation *point = [[MyCustomAnnotation alloc] initWithLocation:coor];
                                 //WithTitle:@"Mc D"
                                 //point.coordinate = coor;
    
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    [self.mapView addAnnotation:point];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MyCustomAnnotation class]])
    {
       
        
        
        MyCustomAnnotation *myLocation = (MyCustomAnnotation *) annotation;
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:28.549787 longitude:77.301316];
        

        
        //******
      //  CLLocation *currentLocation = CLLocationCoordinate2DMake(28.549787,77.301316);


        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                /*
                 addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                 placemark.subThoroughfare, placemark.thoroughfare,
                 placemark.postalCode, placemark.locality,
                 placemark.administrativeArea,
                 placemark.country];
                 */
                myLocation.title = placemark.country;
                myLocation.subtitle = placemark.administrativeArea;

                
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
        
        
        //*******

        
        
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        
        
        //UILabel *addressLabel = [self getAddress];
        //printf("NSString: %s\n", [addressLabel.text UTF8String]);
        if (annotationView == nil)
            annotationView = myLocation.annotationView;
        else
        {
            annotationView.annotation = annotation;
            //   annotationView.detailCalloutAccessoryView = addressLabel;
        }
       // annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        // UILabel *addressLabel = [self getAddress];
        //  printf("NSString: %s\n", addressLabel.text);
        //annotationView.detailCalloutAccessoryView = [self getAddress];
        //NSLog(@"Value of rock = %@", [[self getAddress] text]);
        
        
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
        
    }
    
    else
        return nil;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (![view.annotation isKindOfClass:[MyCustomAnnotation class]])
        return;
    
    // use the annotation view as the sender
    
    [self performSegueWithIdentifier:@"details" sender:view];
}




@end

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
{
    NSMutableArray *placemarksAll;
    UIView *calloutView;

}

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
    placemarksAll = [[NSMutableArray alloc] init];
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
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
        
        //CLLocation *currentLocation1 = annotation.coordinate.;
        
        //******
      //  CLLocation *currentLocation = CLLocationCoordinate2DMake(28.549787,77.301316);


        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            //NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                NSLog(@"%@", placemark.name);
                myLocation.title = [placemark name];
                myLocation.subtitle = placemark.administrativeArea;
               // }

                
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
        
        
        //*******
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        
        
        if (annotationView == nil)
            annotationView = myLocation.annotationView;
        else
        {
            annotationView.annotation = annotation;
        }
        
        
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




- (IBAction)getAtms:(id)sender {
    // Create and initialize a search request object.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"atm";
    request.region = mapView.region;
    
    // Create and initialize a search object.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    // Start the search and display the results as annotations on the map.
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
         {
             // NSMutableArray *placemarksAll = [NSMutableArray array];
             for (MKMapItem *item in response.mapItems) {
                 //[placemarks addObject:item.placemark];
                 //NSLog(@"%@", item.placemark.coordinate.latitude);
                 MyCustomAnnotation *point = [[MyCustomAnnotation alloc] initWithLocation:item.placemark.coordinate];
                 //  [mapView addAnnotation:point];
                 [placemarksAll addObject:point];
                 //[mapView addAnnotation:item.placemark];
                 //[mapView showAnnotations:placemarksAll animated:NO];
                 if ([point conformsToProtocol:@protocol(MKAnnotation)]) {
//[mapView showAnnotations:placemarksAll animated:NO];
    //                 [mapView removeAnnotations:[mapView annotations]];
    
                  //   [self.mapView addAnnotation:point];
                                    }
                 
             }
             //MyCustomAnnotation *point = [[MyCustomAnnotation alloc] init];
             //[mapView removeAnnotations:[mapView annotations]];
             dispatch_async(dispatch_get_main_queue(), ^{
                // [mapView showAnnotations:placemarksAll animated:NO];
             });
         }];
    
    NSLog(@"%lu", (unsigned long)placemarksAll.count);
    
   
     
    
     }

- (IBAction)details:(id)sender {
    /*
    for (int i=(int)placemarksAll.count; i>0; i--)
    {
    [self.mapView showAnnotations:placemarksAll animated:NO];
        [placemarksAll removeObjectAtIndex:i-1];
    }
    */
    for (int i=0; i<placemarksAll.count; i++)
    {
        [self.mapView showAnnotations:placemarksAll animated:NO];
        NSLog(@"%d", i);
    }
    /*
    for (int i=0; i<placemarksAll.count; i++)
    {
        NSLog(@"%lu", (unsigned long)placemarksAll.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", [placemarksAll objectAtIndex:i]);
            [self mapView:self.mapView viewForAnnotation:[placemarksAll objectAtIndex:i]];
            //[NSThread sleepForTimeInterval:.5];
        });
    }
     */

}


@end

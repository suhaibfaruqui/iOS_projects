//
//  DetailViewController.m
//  MyLocationDemo
//
//  Created by User on 12/21/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
{
    CLGeocoder *geocoder1;
    CLPlacemark *placemark1;
    CLLocation *currentLocation1;
}
@synthesize addressLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder1 = [[CLGeocoder alloc] init];

    [self getAddress];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAddress {
    currentLocation1 = [[CLLocation alloc] initWithLatitude:28.549787 longitude:77.301316];
    //placemark1 = [[test alloc]init];
    //placemark1.location = currentLocation;
    
    //NSLog(@"the rock says");
    // NSLog(@"the rock says = %@", placemark1.country);
    //addressLabel.text = placemark1.country;
    
    
    //******
    //  CLLocation *currentLocation = CLLocationCoordinate2DMake(28.549787,77.301316);
    
    
    [geocoder1 reverseGeocodeLocation:currentLocation1 completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks for you: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark1 = [placemarks lastObject];
            NSLog(@"the rock says");
            
            addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@\n%@",
                                 //placemark1.subThoroughfare, placemark1.thoroughfare,
                                 placemark1.postalCode, placemark1.locality,
                                 placemark1.administrativeArea,
                                 placemark1.country];
            
            //myLocation.title = placemark.country;
            //myLocation.subtitle = placemark.administrativeArea;
            
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
   // NSLog(@"the rock says 2");
    
    // Do any additional setup after loading the view.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

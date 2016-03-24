//
//  MyCustomAnnotation.m
//  MyLocationDemo
//
//  Created by User on 12/20/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation
/*
-(id)initWithTitle:(NSString *)newTitile Location:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
        _title = newTitile;
        _coordinate = location;
    }
    return self;
}
*/
@synthesize title;
@synthesize coordinate;
@synthesize subtitle;
-(id)initWithLocation:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
       // _title = newTitile;
        coordinate = location;
    }
    return self;
}



-(MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"map_pin.png"];
    //annotationView.image.size = CGSizeMake(14, 14);
    //UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 15, 0, 0)];
    //fromLabel.text = @"213kkkkbjvhviuycuycyivbvyuviblbuoviuvbb\njbjbjbl\nnknlnn";
     //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //annotationView.detailCalloutAccessoryView = fromLabel;
    return annotationView;
}


@end


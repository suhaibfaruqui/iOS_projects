//
//  MyCustomAnnotation.h
//  MyLocationDemo
//
//  Created by User on 12/20/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *subtitle;

//-(id)initWithTitle:(NSString *)newTitile Location:(CLLocationCoordinate2D)location;
-(id)initWithLocation:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;

@end

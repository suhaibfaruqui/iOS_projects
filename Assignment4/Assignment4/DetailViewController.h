//
//  DetailViewController.h
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *designation;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *tagline;
@property (weak, nonatomic) IBOutlet UILabel *department;
@property (nonatomic, strong) NSString *codeText;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

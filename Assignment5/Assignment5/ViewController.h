//
//  ViewController.h
//  Assignment5
//
//  Created by User on 12/30/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *editView;
- (IBAction)selectImage:(id)sender;
- (IBAction)addText:(id)sender;
- (IBAction)delete:(id)sender;

@end


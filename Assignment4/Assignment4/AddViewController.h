//
//  AddViewController.h
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *designationField;
@property (weak, nonatomic) IBOutlet UITextField *ecodeField;
//@property (weak, nonatomic) IBOutlet UITextField *imageField;
@property (weak, nonatomic) IBOutlet UITextField *taglineField;
@property (weak, nonatomic) IBOutlet UITextField *departmentField;
- (IBAction)saveButton:(id)sender;
- (IBAction)selectPhoto:(id)sender;

@end

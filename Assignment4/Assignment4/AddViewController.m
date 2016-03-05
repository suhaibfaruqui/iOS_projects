//
//  AddViewController.m
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "AddViewController.h"
#import "DBManager.h"
//#import "ALAssetRepresentation.h"

@interface AddViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation AddViewController
{
    NSString *imageurl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Make self the delegate of the textfields.
    self.nameField.delegate = self;
    self.designationField.delegate = self;
    self.ecodeField.delegate = self;
    //self.imageField.delegate = self;
    self.taglineField.delegate = self;
    self.departmentField.delegate = self;
    // Do any additional setup after loading the view.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"testdb.sql"];

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

- (IBAction)saveButton:(id)sender {
    // Prepare the query string.
    self.nameField.text = [self.nameField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.designationField.text = [self.designationField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    self.ecodeField.text = [self.ecodeField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];

    if (![self.nameField.text isEqualToString:@""] && ![self.designationField.text isEqualToString:@""] && ![self.ecodeField.text isEqualToString:@""])
    {
  //  NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', '%@', '%@', '%@', '%@')", self.nameField.text, self.designationField.text, self.ecodeField.text, self.imageField.text, self.taglineField.text, self.departmentField.text];
        NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', '%@', '%@', '%@', '%@')", self.nameField.text, self.designationField.text, self.ecodeField.text, imageurl, self.taglineField.text, self.departmentField.text];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Name, Designation and E-Code are mandatory"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    //NSString *query1 = [NSString stringWithFormat:@"select * from peopleInfo"];
    //[self.dbManager executeQuery:query1];

}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
   // UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"image: %@", imageURL.absoluteString);
    //self.imageField.text = imageURL.absoluteString;
    imageurl = imageURL.absoluteString;
    //self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end

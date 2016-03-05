//
//  ViewController.m
//  Assignment5
//
//  Created by User on 12/30/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer;
-(void)handleRotationWithGestureRecognizer:(UIRotationGestureRecognizer *)rotationGestureRecognizer;
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;
-(void)tapDetected:(UITapGestureRecognizer *)sender;
@end

@implementation ViewController
@synthesize editView;
UIImageView *testView;
static int count=0;
static long count1=1;
static long text_tag=100;
NSMutableArray *array;
UILabel *label;


- (void)viewDidLoad {
    [super viewDidLoad];
    array = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContext(self.editView.bounds.size);
    
    [self.editView.layer renderInContext:UIGraphicsGetCurrentContext()];
      UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage , nil, nil, nil);
}


- (IBAction)selectImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)addText:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter text"
                                                    message:@"  "
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)delete:(id)sender {
    testView = [self.view viewWithTag:count1];
    [testView removeFromSuperview];

}

-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIView *dot1 = pinchGestureRecognizer.view;
    count1 = dot1.tag;
    testView = [self.view viewWithTag:count1];
    testView.transform = CGAffineTransformScale(testView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1.0;
}

-(void)handleRotationWithGestureRecognizer:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    UIView *dot1 = rotationGestureRecognizer.view;
    count1 = dot1.tag;
    testView = [self.view viewWithTag:count1];
    
    testView.transform = CGAffineTransformRotate(testView.transform, rotationGestureRecognizer.rotation);
    
    rotationGestureRecognizer.rotation = 0.0;
}

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    UIView *dot1 = panGestureRecognizer.view;
    count1 = dot1.tag;
    UIImageView *imageView = [self.view viewWithTag:count1];
    // UIImageView *imageView = panGestureRecognizer;
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    imageView.center = touchLocation;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        label=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 250, 250)];
        label.text = [alertView textFieldAtIndex:0].text;
        label.numberOfLines = 0;
        label.tag = text_tag +1;
        text_tag++;
        [label setFont:[UIFont boldSystemFontOfSize:30]];
        [label sizeToFit];
        [label setUserInteractionEnabled:YES];

        //******** gestures added
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        singleTap.numberOfTapsRequired = 1;
        [label addGestureRecognizer:singleTap];
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
        [label addGestureRecognizer:panGestureRecognizer];
        UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationWithGestureRecognizer:)];
        [label addGestureRecognizer:rotationGestureRecognizer];
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
        [label addGestureRecognizer:pinchGestureRecognizer];

        //********
        
        [self.editView addSubview:label];
        //count = count +1;
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(50,50,220,220)];
    dot.tag = count+1;
    dot.image = chosenImage;
    [array addObject:dot ];
    [self.editView addSubview:[array objectAtIndex:count]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    //******** gestures added
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    singleTap.numberOfTapsRequired = 1;
    [[array objectAtIndex:count] setUserInteractionEnabled:YES];
    [[array objectAtIndex:count] addGestureRecognizer:singleTap];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [[array objectAtIndex:count] addGestureRecognizer:panGestureRecognizer];
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationWithGestureRecognizer:)];
    [[array objectAtIndex:count] addGestureRecognizer:rotationGestureRecognizer];
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
    [[array objectAtIndex:count] addGestureRecognizer:pinchGestureRecognizer];
    count = count +1;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)tapDetected:(UITapGestureRecognizer*)sender{
    UIView *dot1 = sender.view;
    count1 = dot1.tag;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

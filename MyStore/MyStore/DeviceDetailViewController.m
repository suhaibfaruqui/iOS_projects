//
//  DeviceDetailViewController.m
//  MyStore
//
//  Created by Simon on 10/12/12.
//  Copyright (c) 2012 Appcoda. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()
-(void)loadInfoToEdit;


@end

@implementation DeviceDetailViewController
NSManagedObject *device;
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // NSManagedObject *device = [[NSManagedObject alloc] init];
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    if (self.recordIDToEdit == -1)
    {
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:self.nameTextField.text forKey:@"name"];
    [newDevice setValue:self.versionTextField.text forKey:@"version"];
    [newDevice setValue:self.companyTextField.text forKey:@"company"];
    }
    else
    {
        [device setValue:self.nameTextField.text forKey:@"name"];
        [device setValue:self.versionTextField.text forKey:@"version"];
        [device setValue:self.companyTextField.text forKey:@"company"];
          }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadInfoToEdit{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    NSMutableArray *devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    device = [devices objectAtIndex:self.recordIDToEdit];
    self.nameTextField.text = [device valueForKey:@"name"];
    self.versionTextField.text = [device valueForKey:@"version"];
    self.companyTextField.text = [device valueForKey:@"company"];
}
@end

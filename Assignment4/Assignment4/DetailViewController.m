//
//  DetailViewController.m
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "DetailViewController.h"
#import "DBManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DetailViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;

-(void)loadData;

@end

@implementation DetailViewController
@synthesize code;
@synthesize codeText;
@synthesize name;
@synthesize designation;
@synthesize department;
@synthesize tagline;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.code.text = codeText;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"testdb.sql"];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    // Form the query.
    
    NSString *query = [NSString stringWithFormat:@"select * from peopleInfo where code = '%@'", self.codeText];
    //NSString *query = @"select * from peopleInfo";
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfDesignation = [self.dbManager.arrColumnNames indexOfObject:@"designation"];
    NSInteger indexOfImage = [self.dbManager.arrColumnNames indexOfObject:@"image"];
    NSInteger indexOfTagline = [self.dbManager.arrColumnNames indexOfObject:@"tagline"];
    NSInteger indexOfDepartment = [self.dbManager.arrColumnNames indexOfObject:@"department"];
    
    self.name.text = [[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfName];
    self.designation.text = [[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfDesignation];
    self.department.text = [[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfDepartment];
    self.tagline.text = [[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfTagline];
    
    
    //******** for displaying image
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        @autoreleasepool {
            CGImageRef iref = [rep fullScreenImage];
            if (iref) {
                UIImage *image = [UIImage imageWithCGImage:iref];
                self.image.image = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //UIMethod trigger...
                });
                iref = nil;
            }
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:[NSURL URLWithString:[[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfImage]]
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
    //*****
    
    
    // Reload the table view.
  //  [self.tblPeople reloadData];
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

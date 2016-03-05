//
//  SearchViewController.m
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "SearchViewController.h"
#import "DBManager.h"
#import "DetailViewController.h"

@interface SearchViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;

-(void)loadData;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.delegate = self;
    self.designation.delegate = self;
    self.code.delegate = self;
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"testdb.sql"];

    // Do any additional setup after loading the view.
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

-(void)loadData{
    // Form the query.
    
   NSString *query = [NSString stringWithFormat:@"select * from peopleInfo where name = '%@' or designation = '%@' or code = '%@'", self.name.text, self.designation.text, self.code.text];
    //NSString *query = @"select * from peopleInfo";
    // Get the results.
   
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    if ([self.arrPeopleInfo count] == 0)
        
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"There are no records to display"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }


    // Reload the table view.
    [self.tblPeople reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPeopleInfo.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
   // NSLog(@"suhaib2");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfDesignation = [self.dbManager.arrColumnNames indexOfObject:@"designation"];
    NSInteger indexOfCode = [self.dbManager.arrColumnNames indexOfObject:@"code"];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Code: %@ ", [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfName] capitalizedString], [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCode]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Designation: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDesignation]];

    
    return cell;
}



- (IBAction)search:(id)sender {
 //   NSLog(@"suhaib");

    [self loadData];
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSIndexPath *indexPath = [self.tblPeople indexPathForSelectedRow];
        NSInteger indexOfCode = [self.dbManager.arrColumnNames indexOfObject:@"code"];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.codeText = [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCode];
    }
}

@end

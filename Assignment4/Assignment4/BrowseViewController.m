//
//  BrowseViewController.m
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "BrowseViewController.h"
#import "DBManager.h"


@interface BrowseViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;


-(void)loadData;

@end

@implementation BrowseViewController
{
    NSArray *myLoadedArray;
    int count;
    int count1;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;    count1 = 0;
    // Make self the delegate and datasource of the table view.
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;
   // self.sortView.delegate = self;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"testdb.sql"];
    
   // myLoadedArray = [NSArray arrayWithObjects:@"2 tablespoons unsalted butter", @"4 cups thinly sliced shallots", @"2 teaspoons fresh thyme", @"1/4 cup grainy Dijon mustard", @"8 slices rustic white bread", @"8 slices Gruyere cheese", @"8 ounces sliced cooked ham", nil];

    // Do any additional setup after loading the view.
    [self loadData];
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
    NSString *query = @"select * from peopleInfo";
    
    // Get the results.
       if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
   // if ([[self.arrPeopleInfo objectAtIndex:0] objectAtIndex:indexOfName] == nil)
        if ([self.arrPeopleInfo count] == 0)

    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Please add an employee by tapping on add item"
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfDesignation = [self.dbManager.arrColumnNames indexOfObject:@"designation"];
    NSInteger indexOfCode = [self.dbManager.arrColumnNames indexOfObject:@"code"];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Code: %@ ", [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfName] capitalizedString], [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCode]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Designation: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfDesignation]];
    
    return cell;
}

- (IBAction)sortName:(id)sender {
    NSString *query;
    if (count == 0)
    {
        query = @"select * from peopleInfo order by name asc";
        count++;
    }
    else
    {
        query = @"select * from peopleInfo order by name desc";
        count--;
    }
    
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblPeople reloadData];
    //[self loadData];
}

- (IBAction)sortCode:(id)sender {
    NSString *query;
    if (count1 == 0)
    {
        query = @"select * from peopleInfo order by code asc";
        count1++;
    }
    else
    {
        query = @"select * from peopleInfo order by code desc";
        count1--;
    }
    
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblPeople reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        int recordIDToDelete = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from peopleInfo where peopleInfoID=%d", recordIDToDelete];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}
@end

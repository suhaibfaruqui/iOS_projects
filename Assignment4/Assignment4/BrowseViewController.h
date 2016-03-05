//
//  BrowseViewController.h
//  Assignment4
//
//  Created by User on 12/26/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblPeople;
- (IBAction)sortName:(id)sender;
- (IBAction)sortCode:(id)sender;

@end

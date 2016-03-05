//
//  DetailTableViewController.m
//  Assignment1
//
//  Created by User on 12/10/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Recipe.h"
#import "TableViewController.h"

@interface DetailTableViewController ()



@end

@implementation DetailTableViewController

//@synthesize recipeLabel;
//@synthesize recipeName;
@synthesize recipe;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = recipe.name;
    self.prepTimeLabel.text = recipe.prepTime;
    self.recipePhoto.image = [UIImage imageNamed:recipe.imageFile];
    
    NSMutableString *ingredientText = [NSMutableString string];
    for (NSString* ingredient in recipe.ingredients) {
        [ingredientText appendFormat:@"%@\n", ingredient];
    }
    self.ingredientTextView.text = ingredientText;
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

@end

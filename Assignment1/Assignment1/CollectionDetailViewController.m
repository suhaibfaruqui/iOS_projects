//
//  CollectionDetailViewController.m
//  Assignment1
//
//  Created by User on 12/12/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import "CollectionDetailViewController.h"
#import "RecipeCollectionViewController.h"

@interface CollectionDetailViewController ()

@end

@implementation CollectionDetailViewController
@synthesize Image;
@synthesize Label;
@synthesize recipeName;


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.Image.image = Image;
    Label.text = recipeName;
    Image.image = [UIImage imageNamed:recipeName];
    
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

@end

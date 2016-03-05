//
//  DetailTableViewController.h
//  Assignment1
//
//  Created by User on 12/10/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface DetailTableViewController : UIViewController
//@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;
//@property (nonatomic, strong) NSString *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *recipePhoto;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;
@property (nonatomic, strong) Recipe *recipe;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;


@end

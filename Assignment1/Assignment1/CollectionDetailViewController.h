//
//  CollectionDetailViewController.h
//  Assignment1
//
//  Created by User on 12/12/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (nonatomic, strong) NSString *recipeName;


@end

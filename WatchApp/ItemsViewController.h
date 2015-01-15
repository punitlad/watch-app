//
//  ItemsViewController.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <ShoppingListAPI/ShoppingList.h>

@interface ItemsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property ShoppingList *shoppingList;
@property (strong, nonatomic) IBOutlet UITableView *itemsTableView;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
- (BOOL) inputIsEmpty;
@end

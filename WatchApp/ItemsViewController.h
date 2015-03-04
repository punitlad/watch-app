//
//  ItemsViewController.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShoppingListAPI/ShoppingList.h>
#import "MMWormhole.h"
#import "TRAutocompleteView.h"
#import "TRAutocompleteItemsSource.h"
#import "TRAutocompletionCellFactory.h"

@interface ItemsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, TRAutocompleteItemsSource, TRAutocompletionCellFactory>
@property ShoppingList *shoppingList;
@property (strong, nonatomic) IBOutlet UITableView *itemsTableView;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property MMWormhole *wormhole;
@property TRAutocompleteView *autocompleteView;
@property NSArray *suggestions;
- (BOOL) inputIsEmpty;
- (void)receiveNotification:(NSNotification*)notification;
@end

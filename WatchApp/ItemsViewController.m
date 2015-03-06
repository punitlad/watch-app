//
//  ItemsViewController.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemsViewController.h"
#import "WatchApp-Swift.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

@synthesize itemsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemTextField.delegate = self;

//    [[[ShoppingList alloc] initWithSampleData] save];
    
    self.shoppingList = [ShoppingList load];
    
    self.suggestions = [self.shoppingList allSuggestions];
    
    self.autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:self.itemTextField
                                                         usingSource:self
                                                         cellFactory:self
                                                        presentingIn:self];
    
    __weak typeof(self) weakSelf = self;
    self.autocompleteView.didAutocompleteWith = ^(id <TRSuggestionItem> suggestion) {
        [weakSelf processTextInput];
    };

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveNotification:) name:@"applicationDidBecomeActive" object:nil];
    
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.tw.WatchApp"
                                                         optionalDirectory:@"wormhole"];
    
    [self.wormhole listenForMessageWithIdentifier:@"watchHasChangedData"
                                         listener:^(id messageObject) {
                                             // Do Something
                                             NSLog(@"watch has changed data");
                                             self.shoppingList = [ShoppingList load];
                                             [self.itemsTableView reloadData];
                                         }];
}

- (void)receiveNotification:(NSNotification*)notification {
    if ([notification.name  isEqual:@"applicationDidBecomeActive"]) {
        self.shoppingList = [ShoppingList load];
        [self.itemsTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    if (section == 0) {
        return self.shoppingList.sortedItems.count;
    } else if (section == 1) {
        return self.shoppingList.sortedCompletedItems.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ItemTableViewCell alloc] init];
    }
    
    if (indexPath.section == 0) {
        [cell bindTo:self.shoppingList.sortedItems[indexPath.row]];
    } else if (indexPath.section == 1) {
        [cell bindTo:self.shoppingList.sortedCompletedItems[indexPath.row]];
    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"To buy";
    if (section == 1)
        return @"Got it";
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // dismiss keyboard
    [self.itemTextField resignFirstResponder];
    
    ItemTableViewCell *cell = (ItemTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.item check];
    [cell rebind];
    
    [self.shoppingList updateLists];
    [self.shoppingList save];
    
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section == 0 ? 1 : 0];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [tableView reloadData];
    }];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:newPath];
    [CATransaction commit];
    
    [self.wormhole passMessageObject:@{@"titleString" : @"title"}
                          identifier:@"phoneHasChangedData"];
}

- (void)processTextInput {
    [self.itemTextField resignFirstResponder];
    
    if (![self inputIsEmpty]) {
        
        Item *item;
        if ((item = [self.shoppingList itemWithName:self.itemTextField.text]) != nil) {
            NSArray *list = item.checked ? self.shoppingList.sortedCompletedItems : self.shoppingList.sortedItems;
            int index = (int)[list indexOfObject:item];
            NSIndexPath *fromPath = [NSIndexPath indexPathForRow:index inSection:item.checked ? 1 : 0];
            NSIndexPath *toPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [item bringBack];
            [self.shoppingList updateLists];
            [self.shoppingList save];
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                [self.itemsTableView reloadData];
            }];
            [self.itemsTableView moveRowAtIndexPath:fromPath toIndexPath:toPath];
            [CATransaction commit];
            
        } else {
            item = [[Item alloc] initWith:self.itemTextField.text];
            [self.shoppingList addItem:item];
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                [self.itemsTableView reloadData];
            }];
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.itemsTableView insertRowsAtIndexPaths:@[newPath] withRowAnimation:UITableViewRowAnimationTop];
            [CATransaction commit];
        }
        
        [self.wormhole passMessageObject:@{@"titleString" : @"title"}
                              identifier:@"phoneHasChangedData"];
        
        [self.shoppingList save];
        self.itemTextField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.itemTextField) {
        [self processTextInput];
        
        return NO;
    }
    return YES;
}

- (BOOL) inputIsEmpty {
    NSString *string = self.itemTextField.text;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return [trimmedString length] == 0;
}

- (IBAction)editingDidEnd:(id)sender {
}

- (NSUInteger)minimumCharactersToTrigger {
    return 1;
}

- (void)itemsFor:(NSString *)query whenReady:(void (^)(NSArray *))suggestionsReady {
    NSMutableArray *suggestions = [[NSMutableArray alloc] init];
    
    NSString *queryLowercase = [query lowercaseString];
    for (NSString *suggestion in self.suggestions) {
        NSString *itemNameLowercase = [suggestion lowercaseString];
        if ([itemNameLowercase hasPrefix:queryLowercase]) {
            [suggestions addObject:[SuggestionItem withText:suggestion]];
        }
    }
    
    suggestionsReady(suggestions);
    self.autocompleteView.hidden = (suggestions.count == 0);
}

- (id <TRAutocompletionCell>)createReusableCellWithIdentifier:(NSString *)identifier {
    ItemSuggestionCell *cell = [[ItemSuggestionCell alloc]
                                            initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:identifier];
    return cell;
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

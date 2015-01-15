//
//  ItemsViewController.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemTableViewCell.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

@synthesize itemsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemTextField.delegate = self;
    
    self.shoppingList = [ShoppingList load];
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.itemTextField) {
        [textField resignFirstResponder];
        
        if (![self inputIsEmpty]) {
            Item *item = [[Item alloc] initWith:textField.text];
            [self.shoppingList addItem:item];
            [self.shoppingList save];

            textField.text = @"";

            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                [self.itemsTableView reloadData];
            }];
            NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.itemsTableView insertRowsAtIndexPaths:@[newPath] withRowAnimation:UITableViewRowAnimationTop];
            [CATransaction commit];
        }
        
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return (textField == self.itemTextField && [self inputIsEmpty]);
}

- (BOOL) inputIsEmpty {
    NSString *string = self.itemTextField.text;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return [trimmedString length] == 0;
}

- (IBAction)editingDidEnd:(id)sender {
    self.itemTextField.text = @"";
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

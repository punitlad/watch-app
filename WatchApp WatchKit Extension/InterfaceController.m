//
//  InterfaceController.m
//  WatchApp WatchKit Extension
//
//  Created by Stephane Bisson on 1/13/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "InterfaceController.h"
#import "ItemTableRowController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.shoppingList = [ShoppingList load];
    [self renderData];
    
//    NSDictionary *data = @{@"from": @"watch"};
//    [WKInterfaceController openParentApplication:data reply:^(NSDictionary *replyInfo, NSError *error) {
//        NSLog(@"reply from ios app d: '%@' and e: '%@'", replyInfo, error);
//    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)renderData {
    [self.itemTable setNumberOfRows:self.shoppingList.sortedItems.count withRowType:@"itemRow"];
    
    int i = 0;
    for (Item *item in self.shoppingList.sortedItems) {
        ItemTableRowController *rowController = [self.itemTable rowControllerAtIndex:i];
        [rowController onItemCheck:^{
            NSLog(@"inside of block...");
            [item check];
            [self.shoppingList updateLists];
            [self.shoppingList save];
            [self renderData];
        }];
        [rowController.itemName setText:item.name];
        i++;
    }
}

@end




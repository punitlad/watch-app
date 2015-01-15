//
//  GlanceInterfaceController.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/15/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "GlanceInterfaceController.h"


@interface GlanceInterfaceController()

@end


@implementation GlanceInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    ShoppingList *shoppingList = [ShoppingList load];
    int itemCount = (int)shoppingList.sortedItems.count;
    
    NSString *info;
    if (itemCount > 10) {
        info = [NSString stringWithFormat:@"You have %d items to buy. You better head to the supermarket.", itemCount];
    } else if (itemCount > 1) {
        info = [NSString stringWithFormat:@"You have only %d items to buy. You could stop at the supermarket tonight.", itemCount];
    } else if (itemCount == 1) {
        info = [NSString stringWithFormat:@"You have only %d item to buy. It surely can wait.", itemCount];
    } else {
        info = @"Nothing to buy at the supermarket for now. Go on with your life ;)";
    }

    [self.infoLabel setText:info];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




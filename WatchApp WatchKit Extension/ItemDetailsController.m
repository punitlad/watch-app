//
//  ItemDetailsController.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/22/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemDetailsController.h"


@interface ItemDetailsController()

@end


@implementation ItemDetailsController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    NSLog(@"ItemDetailsController context: %@", context);
    Item *item = (Item*)context;
    [self.itemName setText:item.name];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)checkButtonPress {
//    [self popController];
    [self dismissController];
}

@end




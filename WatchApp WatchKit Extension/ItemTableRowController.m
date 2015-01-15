//
//  ItemTableRowController.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/13/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemTableRowController.h"

@implementation ItemTableRowController

- (IBAction)buttonPressed {
    self.itemCheckCAllbackBlock();
}

- (void)onItemCheck:(void (^)(void))callbackBlock {
    self.itemCheckCAllbackBlock = callbackBlock;
}
@end

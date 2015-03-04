//
//  InterfaceController.h
//  WatchApp WatchKit Extension
//
//  Created by Stephane Bisson on 1/13/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <ShoppingListAPI/ShoppingList.h>
#import "MMWormhole.h"

@interface InterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceTable *itemTable;
@property ShoppingList *shoppingList;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *messageLabel;
@property MMWormhole *wormhole;
- (void)renderData;
- (void)handleMenuAdd;
- (void)handleMenuRefresh;
- (int)findIndexOfItem:(Item*)item;
- (void)showGotItAllMessage;
- (void)notifyPhoneOfDataChange;
@end

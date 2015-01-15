//
//  InterfaceController.h
//  WatchApp WatchKit Extension
//
//  Created by Stephane Bisson on 1/13/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#include <ShoppingListAPI/ShoppingList.h>

@interface InterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceTable *itemTable;
@property ShoppingList *shoppingList;
-(void)renderData;
@end

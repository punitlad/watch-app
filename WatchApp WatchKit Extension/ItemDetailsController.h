//
//  ItemDetailsController.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/22/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "ShoppingListAPI.h"

@interface ItemDetailsController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *itemName;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *checkButton;

@end

//
//  GlanceInterfaceController.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/15/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#include <ShoppingListAPI/ShoppingList.h>

@interface GlanceInterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *infoLabel;

@end

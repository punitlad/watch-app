//
//  ShoppingList.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ShoppingList : NSObject <NSCoding>
@property NSMutableArray *items;
@property NSArray *sortedItems;
@property NSArray *sortedCompletedItems;
+ (ShoppingList*) load;
- (id) init;
- (id) initWithSampleData;
- (void) addItem:(Item*)item;
- (NSArray*) sort:(BOOL)state;
- (void) updateLists;
- (void) save;
- (Item*) itemWithName:(NSString*)name;
- (NSArray*) allSuggestions;
@end

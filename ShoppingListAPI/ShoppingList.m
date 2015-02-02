//
//  ShoppingList.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ShoppingList.h"
#import "Item.h"

@implementation ShoppingList

+ (ShoppingList*) load {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.tw.WatchApp"];
    [userDefaults synchronize];
    NSData *data = [userDefaults objectForKey:@"shoppingList"];
    ShoppingList *shoppingList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return shoppingList;
}

- (id)init
{
    if( self = [super init] )
    {
        
        self.items = [[NSMutableArray alloc] init];
        [self updateLists];
    }
    
    return self;
}

- (id) initWithSampleData {
    if( self = [super init] )
    {
        
        self.items = [[NSMutableArray alloc] init];
        [self addItem:[[Item alloc] initWith:@"Bread" andState:NO]];
        [self addItem:[[Item alloc] initWith:@"Cheese" andState:NO]];
        [self addItem:[[Item alloc] initWith:@"Wine" andState:YES]];
        [self updateLists];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.items = [coder decodeObjectForKey:@"items"];
        [self updateLists];
    }
    return self;
}

- (void) addItem:(Item*)item {
    [self.items addObject:item];
    [self updateLists];
}

- (NSArray*) sort:(BOOL)state {
    NSPredicate *condition = [NSPredicate predicateWithFormat:@"checked == %@", [NSNumber numberWithBool:state]];
    NSArray *filteredArray = [self.items filteredArrayUsingPredicate:condition];
    NSArray *sortedArray = [filteredArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Item*)a updated];
        NSDate *second = [(Item*)b updated];
        return [second compare:first];
    }];
    
    return sortedArray;
}

- (void) updateLists {
    self.sortedItems = [self sort:NO];
    self.sortedCompletedItems = [self sort:YES];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.items forKey:@"items"];
}

- (void) save {
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.tw.WatchApp"];
    [userDefaults setObject:dataSave forKey:@"shoppingList"];
    [userDefaults synchronize];
}

- (Item*) itemWithName:(NSString*)name {
    NSString *trimmedName = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSPredicate *sameName = [NSPredicate predicateWithFormat:@"name ==[c] %@", trimmedName];
    NSArray *itemsWithSameName = [self.items filteredArrayUsingPredicate:sameName];
    return itemsWithSameName.count > 0 ? itemsWithSameName[0] : nil;
}

- (NSArray*) allSuggestions {
    NSString* path = [[NSBundle bundleForClass:[ShoppingList class]] pathForResource:@"FoodItems" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSArray *array = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    return array;
}

@end

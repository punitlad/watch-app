

#import "ShoppingList.h"
#import "Kiwi.h"

SPEC_BEGIN(ShoppingListSpec)

describe(@"ShoppingList", ^{
    
    context(@"when empty", ^{
        let(shoppingList, ^{
            return [[ShoppingList alloc] init];
        });
        
        it(@"contains no item", ^{
            [[theValue(shoppingList.items.count) should] equal:theValue(0)];
        });
        
        it(@"contains no UNCOMPLETED item", ^{
            [[theValue(shoppingList.sortedItems.count) should] equal:theValue(0)];
        });
        
        it(@"contains no COMPLETED item", ^{
            [[theValue(shoppingList.sortedCompletedItems.count) should] equal:theValue(0)];
        });
        
    });
    
    context(@"with sample data", ^{
        let(shoppingList, ^{
            ShoppingList *shoppingList = [[ShoppingList alloc] init];
            [shoppingList addItem:[[Item alloc] initWith:@"Bread" andState:NO]];
            [shoppingList addItem:[[Item alloc] initWith:@"Cheese" andState:NO]];
            [shoppingList addItem:[[Item alloc] initWith:@"Wine" andState:YES]];
            return shoppingList;
        });
        
        it(@"has 3 items total", ^{
            [[theValue(shoppingList.items.count) should] equal:theValue(3)];
        });
        
        it(@"has 2 UNCOMPLETED items", ^{
            [[theValue(shoppingList.sortedItems.count) should] equal:theValue(2)];
        });
        
        it(@"has 1 COMPLETED item", ^{
            [[theValue(shoppingList.sortedCompletedItems.count) should] equal:theValue(1)];
        });
        
        it(@"returns item with name", ^{
            [[[shoppingList itemWithName:@"Bread"] should] beNonNil];
        });
        
        it(@"returns item with name by ignoring whitespace padding", ^{
            [[[shoppingList itemWithName:@"  Bread   "] should] beNonNil];
        });


        it(@"returns item with name with different case", ^{
            [[[shoppingList itemWithName:@"BREAD"] should] beNonNil];
        });
        
        it(@"returns nil when no item exist with the specified name", ^{
            NSLog(@"olive: %@", [shoppingList itemWithName:@"Olive"]);
            [[[shoppingList itemWithName:@"Olive"] should] beNil];
        });
        
        it(@"adds items at the top", ^{
            Item *item = [[Item alloc] initWith:@"Ratatouille"];
            [shoppingList addItem:item];
            
            [[shoppingList.sortedItems[0] should] equal:item];
        });

    });
});

SPEC_END


#import "ShoppingList.h"
#import "Kiwi.h"

SPEC_BEGIN(ItemSpec)

describe(@"Item", ^{
    
    it(@"is created with a name", ^{
        NSString *itemName = @"name-here";
        Item *item = [[Item alloc] initWith:itemName];
        
        [[item.name should] equal:itemName];
        [[theValue(item.checked) should] equal:theValue(NO)];
    });
    
    it(@"trims the name", ^{
        Item *item = [[Item alloc] initWith:@"    with spaces    "];
        
        [[item.name should] equal:@"with spaces"];
    });
    
    it(@"is created with a name and a state", ^{
        NSString *itemName = @"new-name-here";
        Item *item = [[Item alloc] initWith:itemName andState:YES];
        
        [[item.name should] equal:itemName];
        [[theValue(item.checked) should] equal:theValue(YES)];
    });
    
    it(@"toggles its state", ^{
        Item *item = [[Item alloc] initWith:@"some-name" andState:YES];
        
        [item check];
        
        [[theValue(item.checked) should] equal:theValue(NO)];
    });
    
    it(@"updates its timestamp when toggled", ^{
        Item *item = [[Item alloc] initWith:@"some-name"];
        
        NSDate *timestampBefore = item.updated;
        [item check];
        NSDate *timestampAfter = item.updated;
        
        [[timestampAfter should] beGreaterThan:timestampBefore];
    });
    
});

SPEC_END
//
//  Item.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id) initWith:(NSString*)name {
    return [self initWith:name andState:NO andTimestamp:[NSDate date]];
}

- (id) initWith:(NSString *)name andState:(BOOL)state {
    return [self initWith:name andState:state andTimestamp:[NSDate date]];
}

- (id) initWith:(NSString*)name andState:(BOOL)state andTimestamp:(NSDate*)updated {
    if( self = [super init] )
    {
        NSString *trimmedName = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        self.name = trimmedName;
        self.checked = state;
        self.updated = updated;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    NSString *name = [coder decodeObjectForKey:@"name"];
    BOOL checked = [coder decodeBoolForKey:@"checked"];
    NSDate *updated = [coder decodeObjectForKey:@"updated"];
    return [self initWith:name andState:checked andTimestamp:updated];
}

- (void) check {
    self.checked = !self.checked;
    self.updated = [NSDate date];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeBool:self.checked forKey:@"checked"];
    [coder encodeObject:self.updated forKey:@"updated"];
}

- (void)bringBack {
    self.checked = NO;
    self.updated = [NSDate date];
}

@end

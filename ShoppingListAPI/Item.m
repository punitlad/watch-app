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
    if( self = [super init] )
    {
        self.name = name;
        self.checked = NO;
        self.updated = [NSDate date];
    }
    
    return self;
}

- (id) initWith:(NSString *)name andState:(BOOL)state {
    if( self = [super init] )
    {
        self.name = name;
        self.checked = state;
        self.updated = [NSDate date];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.checked = [coder decodeBoolForKey:@"checked"];
        self.updated = [coder decodeObjectForKey:@"updated"];
    }
    return self;
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

@end

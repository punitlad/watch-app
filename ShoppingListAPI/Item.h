//
//  Item.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>
@property NSString *name;
@property NSDate *updated;
@property BOOL checked;
- (id) initWith:(NSString*)name;
- (id) initWith:(NSString*)name andState:(BOOL)state;
- (void) check;
@end

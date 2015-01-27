//
//  SuggestionItem.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/27/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "SuggestionItem.h"

@implementation SuggestionItem

+ (SuggestionItem*) withText:(NSString*)text {
    SuggestionItem *s = [[SuggestionItem alloc] init];
    s.completionText = text;
    return s;
}

@end

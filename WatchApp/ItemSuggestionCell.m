//
//  ItemSuggestionCell.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/27/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemSuggestionCell.h"
#import "SuggestionItem.h"

@implementation ItemSuggestionCell

- (void)updateWith:(id <TRSuggestionItem>)item {
    SuggestionItem *suggestionItem = (SuggestionItem*)item;
    self.textLabel.text = suggestionItem.completionText;
}

@end

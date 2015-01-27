//
//  SuggestionItem.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/27/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TRAutocompletionCellFactory.h>

@interface SuggestionItem : NSObject <TRSuggestionItem>
@property NSString *completionText;
+ (SuggestionItem*) withText:(NSString*)text;
@end

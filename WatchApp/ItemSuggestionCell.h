//
//  ItemSuggestionCell.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/27/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TRAutocompletionCellFactory.h>

@interface ItemSuggestionCell : UITableViewCell <TRAutocompletionCell>
@property UILabel *label;
@end

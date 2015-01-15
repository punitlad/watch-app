//
//  ItemTableViewCell.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property Item* item;
-(void) bindTo:(Item *)item;
@end

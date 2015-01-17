//
//  ItemTableViewCell.m
//  WatchApp
//
//  Created by Stephane Bisson on 1/12/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindTo:(Item *)item {
    self.item = item;
    
    if (item.checked) {
        NSAttributedString * title =
        [[NSAttributedString alloc] initWithString:item.name
                                        attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        [self.itemNameLabel setAttributedText:title];
        
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.itemNameLabel.text = item.name;
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)rebind {
    [self bindTo:self.item];
}


@end

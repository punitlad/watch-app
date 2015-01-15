//
//  ItemTableRowController.h
//  WatchApp
//
//  Created by Stephane Bisson on 1/13/15.
//  Copyright (c) 2015 Stephane Bisson. All rights reserved.
//

#import <WatchKit/WatchKit.h>

@interface ItemTableRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *itemName;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *checkButton;
@property (copy) void (^itemCheckCAllbackBlock)(void);
- (IBAction)buttonPressed;
- (void)onItemCheck:(void (^)(void))callbackBlock;
@end

//
//  Deck.h
//  Matchismo
//
//  Created by Adam Narkunski on 07/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//
;
#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard: (Card*) card atTop: (BOOL) atTop;
- (void) addCard: (Card*) card;

- (Card*) drawRandomCard;

@end

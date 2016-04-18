//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Adam Narkunski on 07/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingdeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchCount;

@end

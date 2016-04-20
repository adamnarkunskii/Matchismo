//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Adam Narkunski on 07/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index{
    Card* card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other cards
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            for (Card* otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherChosenCards addObject:otherCard];
                }
            }
            
            NSLog(@"otherChosenCards.count = %lu", otherChosenCards.count);
            
            if (otherChosenCards.count == self.matchCount - 1) {
                for (Card* otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (NSMutableArray*)cards{
    if (!_cards){
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingdeck:(Deck *)deck{
    self = [super init];
    if (self){
        self.matchCount = 2;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card*) cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}

@end

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
@property (nonatomic, readwrite) PlayLog* lastPlayLog;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index{
    Card* card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;

            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card* otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            
            if (chosenCards.count == self.matchCount) {
                int matchScore = 0;
                int matchCount = 0;
                for (Card* chosenCard in chosenCards){
                    NSMutableArray* cardsToMatchAgainst = [[NSMutableArray alloc] initWithArray:chosenCards];
                    [cardsToMatchAgainst removeObject:chosenCard];
                    matchScore += [chosenCard match:cardsToMatchAgainst];
                    if (matchScore != 0){
                        matchCount++;
                    }
                }
                
                if (matchScore != 0){
                    for (Card* card in chosenCards){
                        card.matched = YES;
                    }
                    self.score = matchScore * matchCount;
                } else {
                    for (Card* card in chosenCards){
                        card.chosen = NO;
                    }
                    
                    matchScore = -MISMATCH_PENALTY;
                }
                
                self.score += matchScore;
                
                PlayLog* log = [[PlayLog alloc] init];
                log.cards = [[NSMutableArray alloc] initWithArray:chosenCards];
                log.score = matchScore;
                self.lastPlayLog = log;
                
            }
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

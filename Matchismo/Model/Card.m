//
//  Card.m
//  Matchismo
//
//  Created by Adam Narkunski on 06/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *) otherCards {
    int score = 0;
    for (Card *card in otherCards){
        if([self.contents isEqualToString:card.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end

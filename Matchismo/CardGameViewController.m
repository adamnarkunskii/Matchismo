//
//  ViewController.m
//  Matchismo
//
//  Created by Adam Narkunski on 06/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayLog.h"

@interface CardGameViewController ()
@property (nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLogLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetGameButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentGameType;
@end

@implementation CardGameViewController

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenCardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenCardIndex];
    self.segmentGameType.enabled = NO;
    [self updateUI];
}
- (IBAction)touchSegmentedGameType:(UISegmentedControl *)sender {
    [self updateGameConfiguration];
}

-(void)updateGameConfiguration {
    NSUInteger matchCount = [self.segmentGameType selectedSegmentIndex]+2;
    self.game.matchCount = matchCount;
}

-(void) updateUI {
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [self changeCard:cardButton toCard: card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.playLogLabel.text = [self getMessageFrom:self.game.lastPlayLog];
}

-(NSString*) getMessageFrom:(PlayLog*)log{
    if (!log){
        return @"";
    }
    NSMutableArray* cardContents = [[NSMutableArray alloc] init];
    for (Card* card in log.cards){
        [cardContents addObject:card.contents];
    }
    NSString* cards = [cardContents componentsJoinedByString:@""];
    NSString* format;
    if(log.score > 0){
        format = @"Matched %@ for %d points!";
    } else {
        format = @"%@ doesn't match! %d points penalty haha u sux";
    }
    
    return [NSString stringWithFormat:format, cards, log.score];
}

- (void) changeCard:(UIButton*) button toCard:(Card*)card {
    [button setBackgroundImage: [self getImageForCard:card]
                      forState:UIControlStateNormal];
    [button setTitle:[self getTitleForCard: card]
            forState:UIControlStateNormal];
    button.enabled = !card.isMatched;
}

- (NSString*) getTitleForCard:(Card*)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage*) getImageForCard:(Card*)card{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (Deck*) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchResetGameButton:(id)sender {
    _game = nil;
    self.segmentGameType.enabled = YES;
    [self updateGameConfiguration];
    [self updateUI];
}

- (CardMatchingGame*) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingdeck:[self createDeck]];
    }
    return _game;
}

@end

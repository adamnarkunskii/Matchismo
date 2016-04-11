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

@interface CardGameViewController ()
@property (nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenCardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenCardIndex];
    [self updateUI];
}

-(void) updateUI {
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [self changeCard:cardButton toCard: card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
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
    return [[PlayingCardDeck alloc]init];
}

- (CardMatchingGame*) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingdeck:[self createDeck]];
    }
    return _game;
}

@end

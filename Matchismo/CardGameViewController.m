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

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck* deck;
@end

@implementation CardGameViewController

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Updated flips to [%d]" ,self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]){
        [self changeCard:sender toContents:@"" toImage:@"cardback"];
    } else {
        Card *card = [self.deck drawRandomCard];
        if (card){
            [self changeCard:sender toContents:card.contents toImage:@"cardfront"];
        }
    }
}

- (void) changeCard:(UIButton*) sender toContents:(NSString*) contents toImage: (NSString*) imageName {
    [sender setBackgroundImage: [UIImage imageNamed: imageName] forState:UIControlStateNormal];
    [sender setTitle:contents forState:UIControlStateNormal];
    self.flipCount++;
}

- (Deck*) deck {
    if (!_deck){
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (Deck*) createDeck {
    return [[PlayingCardDeck alloc]init];
}



@end

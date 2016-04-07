//
//  Card.h
//  Matchismo
//
//  Created by Adam Narkunski on 06/04/2016.
//  Copyright © 2016 Adam Narkunski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString* contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray*) otherCards;

@end

//
//  CardMatchingGame.m
//  Lecture3Project
//
//  Created by larryhzhang on 2020/8/31.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    // lazy instantiation
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            // 防止nil加入到NSMutableArray中出现crash
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

- (Card *)cardAtIndex:(NSUInteger)index {
    // avoid array out of bounds
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (void)chooseCardIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSLog(@"chooseCardIndex: %d",index);
    // only allow unmatched cards to be chosen
    if (card.isMatched) {
        card.chosen = NO;
    } else {
        // match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    otherCard.matched = YES;
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                }
                break;
            }
        }
        card.chosen = YES;
    }
}

@end

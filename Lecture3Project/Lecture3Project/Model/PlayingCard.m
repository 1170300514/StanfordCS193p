//
//  PlayingCard.m
//  Lecture3Project
//
//  Created by larryhzhang on 2020/8/31.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCard {
    int score = 0;
    
    if ([otherCard count] == 1) {
        // firstObject 相当于 [array objectAtIndex:0]
        // 但好处是array为空时不会报错只会返回nil
        PlayingCard *firstCard = [otherCard objectAtIndex:0];
        if (firstCard.rank == self.rank) {
            score = 4;
        } else if ([firstCard.suit isEqualToString: self.suit]) {
            score = 1;
        }
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

// 类方法
+ (NSArray *)validSuits {
    return @[@"❤",@"◇",@"♥",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end

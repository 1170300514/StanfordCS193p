//
//  Card.m
//  Lecture3Project
//
//  Created by larryhzhang on 2020/8/31.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCard {
    int score = 0;
    
    for (Card *card in otherCard) {
        if ([card.contents isEqualToString: self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (void)setChosen:(BOOL)chosen {
    _chosen = chosen;
}
@end

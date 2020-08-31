//
//  CardMatchingGame.h
//  Lecture3Project
//
//  Created by larryhzhang on 2020/8/31.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount: (NSUInteger)count
                        usingDeck: (Deck *)deck;

- (void)chooseCardIndex: (NSUInteger)index;

- (Card *)cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end

NS_ASSUME_NONNULL_END

//
//  Card.h
//  Lecture3Project
//
//  Created by larryhzhang on 2020/8/31.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property(strong) NSString *contents;

@property(nonatomic, getter=isChosen) BOOL chosen;
@property(nonatomic, getter=isMatched) BOOL matched;

- (int)match: (NSArray *)otherCard;

@end

NS_ASSUME_NONNULL_END

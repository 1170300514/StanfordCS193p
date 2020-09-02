//
//  DropitBehavior.m
//  Lecture8Project
//
//  Created by larryhzhang on 2020/9/2.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "DropitBehavior.h"
// 物理属性实现工具类
@interface DropitBehavior()
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *animatedOptions;
@end

@implementation DropitBehavior
- (instancetype)init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return self;
}

- (UIDynamicItemBehavior *)animatedOptions {
    if (!_animatedOptions) {
        _animatedOptions = [[UIDynamicItemBehavior alloc] init];
        _animatedOptions.allowsRotation = NO;
    }
    return _animatedOptions;
}

- (UIGravityBehavior *)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

- (UICollisionBehavior *)collider {
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

- (void)addItem:(id<UIDynamicItem>)item {
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animatedOptions addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item {
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}
@end

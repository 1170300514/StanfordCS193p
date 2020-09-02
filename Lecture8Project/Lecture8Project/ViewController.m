//
//  ViewController.m
//  Lecture8Project
//
//  Created by larryhzhang on 2020/9/2.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropitBehavior *dropitBehavior;
@end

@implementation ViewController

static const CGSize DROP_SIZE = {40, 40};

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    }
    return _animator;
}

// 实现协议
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    NSLog(@"jump into dynamicAnimatorDidPause");
    [self removeCompleteRows];
}

- (void)removeCompleteRows {
    NSMutableArray *dropToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y = self.gameView.bounds.size.height-DROP_SIZE.height/2; y>0; y-=DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width-DROP_SIZE.width/2; x += DROP_SIZE.width) {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview] == self.gameView) {
                [dropsFound addObject:hitView];
            } else {
                rowIsComplete = NO;
                break;
            }
        }
        if (![dropToRemove count]) {
            break;
        }
        if (rowIsComplete) {
            [dropToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropToRemove count]) {
        for (UIView *drop in dropToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropToRemove];
    }
}

// 移除最后一行
- (void)animateRemovingDrops:(NSArray *)dropToRemove {
    [UIView animateWithDuration:1.0
                     animations:^{
        for (UIView *drop in dropToRemove) {
            int x = (arc4random()%(int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
            int y = self.gameView.bounds.size.height;
            drop.center = CGPointMake(x, -y);
        }
    }
                     completion:^(BOOL finished){
        [dropToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}

- (DropitBehavior *)dropitBehavior {
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    // 出现方块时的x轴偏移量
    int x = (arc4random() % (int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    //
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
    [self.dropitBehavior addItem:dropView];
}

- (UIColor *)randomColor {
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

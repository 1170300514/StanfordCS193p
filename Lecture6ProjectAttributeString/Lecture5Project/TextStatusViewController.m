//
//  TextStatusViewController.m
//  Lecture5Project
//
//  Created by larryhzhang on 2020/9/1.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "TextStatusViewController.h"

@interface TextStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;

@end

@implementation TextStatusViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu Colorful Characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%lu Outline Characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *character = [[NSMutableAttributedString alloc] init];
    
    NSUInteger index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        
        // 查找一段字符串中具有相同属性的值
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            // 获取具有相同属性字符串
            [character appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    
    return character;
}

@end

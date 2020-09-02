//
//  ViewController.m
//  Lecture5Project
//
//  Created by larryhzhang on 2020/9/1.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "ViewController.h"
#import "TextStatusViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation ViewController

// 跳转前传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 1. 首先判断segue的identifier
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        // 2. 然后判断目标控制器类型
        if ([segue.destinationViewController isKindOfClass:[TextStatusViewController class]]) {
            // 3. 实例化页面
            TextStatusViewController *tsvc = (TextStatusViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
    }
}

// 更改字体颜色
- (IBAction)change:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

// 加粗字体
- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                            NSStrokeColorAttributeName : [UIColor blackColor]
    } range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.outlineButton.currentTitle) {
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
        [title setAttributes:@{NSStrokeWidthAttributeName : @3,
                               NSStrokeColorAttributeName : self.outlineButton.tintColor}
                       range: NSMakeRange(0, [title length])];
        [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    // 通知机制：注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredFontsChanged:(NSNotification *)notification {
    [self usePreferredFonts];
}

- (void)usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}


@end

//
//  ViewController.m
//  Lecture10Project
//
//  Created by larryhzhang on 2020/9/3.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        NSString *string;
        if ([segue.identifier isEqualToString:@"1"]) {
            string = @"https://lh6.ggpht.com/ZoD88QrTxZbZnhpJgQbo9SPuosryX9ujjdRaHvjjvbUGeZcI-9C4AFQsWQm7-pVDv1E=h900";
        } else if ([segue.identifier isEqualToString:@"2"]) {
            string = @"http://news.nationalgeographic.com/content/dam/news/2016/02/12/01asteroidearth.jpg";
        } else if ([segue.identifier isEqualToString:@"3"]) {
            string = @"https://lh5.ggpht.com/j4C_pXnbRc5FnxNO90wIqodn4QA3f_6rB0cyu2sVnCeSwLDmyZf-xSrC9L8c3oxr6NE=h900";
        }
        ivc.imageURL = [NSURL URLWithString:string];
        ivc.title = segue.identifier;
    }
}


@end

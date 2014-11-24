//
//  HourLabel.m
//  PeekInspiredTimePicker
//
//  Created by Adam Cooper on 11/24/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "HourLabel.h"

@implementation HourLabel

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {0, 0, 0, 20};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

-(void)backgroundColorAnimationFromColor:(UIColor *)startColor toColor:(UIColor *)destColor clearAnimationsFirst:(BOOL)reset {
    if (reset)
    {
        self.backgroundColor = [UIColor clearColor];
        [self.layer removeAllAnimations];
    }

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 0.4f;
    animation.autoreverses = YES;
    animation.fromValue = (id) startColor.CGColor; // [NSNumber numberWithFloat:1.0];
    animation.toValue = (id) destColor.CGColor; //[NSNumber numberWithFloat:0.10];
    [self.layer addAnimation:animation forKey:@"backgroundColor"];
}



@end

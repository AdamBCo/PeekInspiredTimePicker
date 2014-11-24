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
    animation.duration = 0.41f;
    animation.autoreverses = YES;
    animation.fromValue = (UIColor *) startColor.CGColor;
    animation.toValue = (UIColor *) destColor.CGColor;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"backgroundColor"];
}



@end

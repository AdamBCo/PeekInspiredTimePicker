//
//  MinuteLabel.h
//  PeekInspiredTimePicker
//
//  Created by Adam Cooper on 11/24/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinuteLabel : UILabel

-(void)backgroundColorAnimationFromColor:(UIColor *)startColor toColor:(UIColor *)destColor clearAnimationsFirst:(BOOL)reset;

@end

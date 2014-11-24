//
//  HourViewController.h
//  PunctualTime
//
//  Created by Adam Cooper on 11/10/14.
//  Copyright (c) 2014 The Timers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HourViewDelegate

-(void)hourSelected:(NSString *)string;

@end

@interface HourViewController : UIViewController

@property id<HourViewDelegate> delegate;

@end

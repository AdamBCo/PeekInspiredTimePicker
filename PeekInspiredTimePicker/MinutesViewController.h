//
//  MinutesViewController.h
//  PunctualTime
//
//  Created by Adam Cooper on 11/10/14.
//  Copyright (c) 2014 The Timers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MinuteViewDelegate

-(void)minuteSelected:(NSString *)string;

@end

@interface MinutesViewController : UIViewController

@property id<MinuteViewDelegate> delegate;

@end

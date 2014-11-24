//
//  HourViewController.m
//  PunctualTime
//
//  Created by Adam Cooper on 11/10/14.
//  Copyright (c) 2014 The Timers. All rights reserved.
//

#import "HourViewController.h"
#import "HourLabel.h"

@interface HourViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *draggableLabel;
@property (strong, nonatomic) IBOutletCollection(HourLabel) NSArray *hourLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property NSDateFormatter *dateFormatter;

@end


@implementation HourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateFormatter = [NSDateFormatter new];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self calculateStartingPositionsOfLabels];

}

-(void)calculateStartingPositionsOfLabels{

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
    NSInteger hour = [components hour];

    if (hour > 12) {
        NSString *newValue = @(hour-12).stringValue;

        for (HourLabel *hourLabel in self.hourLabels) {
            if ([hourLabel.text isEqualToString:newValue]){
                self.draggableLabel.text = hourLabel.text;
                self.topLayoutConstraint.constant = hourLabel.center.y - hourLabel.frame.size.height;
                [self.delegate hourSelected:hourLabel.text];
            }
        }
    } else if (hour < 12){

        for (HourLabel *hourLabel in self.hourLabels) {
            if ([hourLabel.text isEqualToString:@(hour).stringValue]){
                self.draggableLabel.text = hourLabel.text;
                self.topLayoutConstraint.constant = hourLabel.center.y - hourLabel.frame.size.height;
                [self.delegate hourSelected:hourLabel.text];
            }
        }

    }

}


-(IBAction)tap:(UITapGestureRecognizer *)gesture{


    CGPoint point = [gesture locationInView:self.view];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setFromValue:[NSValue valueWithCGPoint:self.draggableLabel.center]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(self.draggableLabel.center.x, point.y)]];
    [animation setDuration:0.4f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.draggableLabel.layer setPosition:CGPointMake(self.draggableLabel.center.x, point.y)];
    [self.draggableLabel.layer addAnimation:animation forKey:@"position"];

    for (HourLabel *hourLabel in self.hourLabels) {

        if (CGRectContainsPoint(hourLabel.frame, self.draggableLabel.center)){

            [hourLabel backgroundColorAnimationFromColor:hourLabel.backgroundColor toColor:[UIColor greenColor] clearAnimationsFirst:YES];

            self.draggableLabel.text = hourLabel.text;
            self.topLayoutConstraint.constant = hourLabel.center.y - hourLabel.frame.size.height;
            [self.delegate hourSelected:self.draggableLabel.text];
        }
    }
    
}


-(IBAction)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.view];


    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        self.draggableLabel.center = CGPointMake(self.draggableLabel.center.x, point.y);
    } else if (gesture.state == UIGestureRecognizerStateEnded ||
               gesture.state == UIGestureRecognizerStateFailed ||
               gesture.state == UIGestureRecognizerStateCancelled){
        for (HourLabel *hourLabel in self.hourLabels) {
            if (CGRectContainsPoint(hourLabel.frame, self.draggableLabel.center)){
                self.draggableLabel.text = hourLabel.text;
                self.draggableLabel.center = hourLabel.center;
                self.topLayoutConstraint.constant = hourLabel.center.y - hourLabel.frame.size.height;
                [self.delegate hourSelected:hourLabel.text];
            }
        }
    }
}


@end

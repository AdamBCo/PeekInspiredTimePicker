//
//  MinutesViewController.m
//  PunctualTime
//
//  Created by Adam Cooper on 11/10/14.
//  Copyright (c) 2014 The Timers. All rights reserved.
//

#import "MinutesViewController.h"

@interface MinutesViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *draggableLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *minuteLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;


@end

@implementation MinutesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self calculateStartingPositionsOfLabels];

}

-(void)calculateStartingPositionsOfLabels{

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:now];
    NSInteger minutes = [components minute];
    float minuteUnit = ceil((float) minutes / 5.0);
    minutes = minuteUnit * 5.0;

    for (UILabel *minuteLabel in self.minuteLabels) {
        if ([minuteLabel.text isEqualToString:@(minutes).stringValue]){
                self.draggableLabel.text = minuteLabel.text;
                self.topConstraint.constant = minuteLabel.center.y - minuteLabel.frame.size.height;
                [self.delegate minuteSelected:minuteLabel.text];
            }
        }
    
}

-(IBAction)tap:(UITapGestureRecognizer *)gesture{

    CGPoint point = [gesture locationInView:self.view];
    self.draggableLabel.center = CGPointMake(self.draggableLabel.center.x, point.y);
    for (UILabel *minuteLabel in self.minuteLabels) {
        if (CGRectContainsPoint(minuteLabel.frame, self.draggableLabel.center)){
            self.draggableLabel.text = minuteLabel.text;
            self.topConstraint.constant = minuteLabel.center.y - minuteLabel.frame.size.height;
            [self.delegate minuteSelected:minuteLabel.text];
        }
    }

}

-(IBAction)pan:(UIPanGestureRecognizer *)gesture {

    //
    CGPoint point = [gesture locationInView:self.draggableLabel.superview];

    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        self.draggableLabel.center = CGPointMake(self.draggableLabel.center.x, point.y);
    } else if (gesture.state == UIGestureRecognizerStateEnded ||
               gesture.state == UIGestureRecognizerStateFailed ||
               gesture.state == UIGestureRecognizerStateCancelled){
        for (UILabel *minuteLabel in self.minuteLabels) {
            if (CGRectContainsPoint(minuteLabel.frame, self.draggableLabel.center)){
                self.draggableLabel.text = minuteLabel.text;
                self.topConstraint.constant = minuteLabel.center.y - minuteLabel.frame.size.height;
                [self.delegate minuteSelected:minuteLabel.text];
            }
        }
    }
}

@end

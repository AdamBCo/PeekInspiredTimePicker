//
//  ViewController.m
//  PeekInspiredTimePicker
//
//  Created by Adam Cooper on 11/23/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ViewController.h"
#import "MinutesViewController.h"
#import "HourViewController.h"


@interface ViewController () <UIGestureRecognizerDelegate, MinuteViewDelegate, HourViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *timeOfDaySwitch;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeOfDaySwitch.frame = CGRectMake(0, 0, 44, 44);
    self.timeOfDaySwitch.clipsToBounds = YES;
    self.timeOfDaySwitch.layer.cornerRadius = 44/2.0f;
    self.timeOfDaySwitch.layer.borderWidth=1.0f;

    self.checkButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.closeButton.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
    NSInteger hour = [components hour];

    if (hour < 12) {
        self.timeOfDaySwitch.backgroundColor = [UIColor redColor];
        [self.timeOfDaySwitch setTitle:@"AM" forState:UIControlStateNormal];
        self.timeOfDaySwitch.tag = 1;

    } else {
        self.timeOfDaySwitch.backgroundColor = [UIColor greenColor];
        [self.timeOfDaySwitch setTitle:@"PM" forState:UIControlStateNormal];
        self.timeOfDaySwitch.tag = 0;
    }

}

-  (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"MinutesSegue"]) {
        MinutesViewController *minutesViewController = segue.destinationViewController;
        minutesViewController.delegate = self;

    } else if ([segue.identifier isEqualToString:@"HourSegue"]){
        HourViewController *hoursViewController = segue.destinationViewController;
        hoursViewController.delegate = self;

    }
}

- (IBAction)onTimeOfDayButtonPressed:(UIButton *)sender {

    if (sender.tag == 0) {
        self.timeOfDaySwitch.backgroundColor = [UIColor redColor];
        [self.timeOfDaySwitch setTitle:@"AM" forState:UIControlStateNormal];
        sender.tag++;
    } else {
        self.timeOfDaySwitch.backgroundColor = [UIColor greenColor];
        [self.timeOfDaySwitch setTitle:@"PM" forState:UIControlStateNormal];
        sender.tag--;
    }
}


-(void)minuteSelected:(NSString *)string{
    NSLog(@"Minute: %@",string);
}

-(void)hourSelected:(NSString *)string{
    NSLog(@"Hour: %@",string);
}
- (IBAction)onCloseButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onCheckButtonPressed:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
}



@end

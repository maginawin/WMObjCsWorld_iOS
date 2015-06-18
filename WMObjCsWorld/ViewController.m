//
//  ViewController.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "ViewController.h"
#import "WMBleManagerViewController.h"
#import "NSDate+Calendar.h"
#import "WMCountDownLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WMCountDownLabel *countDownLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)bleManagerDemo:(id)sender {
    // 以下两种初始化方法都可以
    //    WMBleManagerViewController* bmVC = [[WMBleManagerViewController alloc] initWithNibName:@"WMBleManagerViewController" bundle:nil];
    WMBleManagerViewController* bmVC = [[WMBleManagerViewController alloc] init];
    [self.navigationController pushViewController:bmVC animated:YES];
}

- (IBAction)dateCalendarTestClick:(id)sender {
    NSDate* date = [NSDate date];
    WMLog(@"今天的日, 月, 年 分别是:%d, %d, %d", (int)[date day], (int)[date month], (int)[date year]);
    WMLog(@"这个月第一个星期有 %d 天", (int)[date numberOfDaysInCurrentMonth]);
    WMLog(@"这个月有 %d 个星期", (int)[[date lastMonthDate:date] numberOfWeeksInCurrentMonth]);
    WMLog(@"这个月第一天是星期 : %d", (int)[[date lastMonthDate:date] firstWeekDayInMonth]);
    WMLog(@"上一个月的日期是 : %@", [date lastMonthDate:date]);
    WMLog(@"下一个月的日期是 : %@", [date nextMonthDate:date]);
    WMLog(@"今天是星期第几 : %d", (int)[date dayOfWeek]);
}

- (IBAction)startCountDownClick:(id)sender {
    [_countDownLabel setupCountDownSeconds:888];
    [_countDownLabel start];
}

- (IBAction)stopCountDownClick:(id)sender {
    [_countDownLabel stop];
}

- (IBAction)sqliteClick:(id)sender {
}



@end

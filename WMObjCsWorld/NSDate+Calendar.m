//
//  NSData+Calendar.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/15.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (int)year {
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return (int)components.year;
}

- (int)month {
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return (int)components.month;
}

- (int)day {
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return (int)components.day;
}

- (int)dayOfWeek {
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay;
    comps = [gregorian components:unitFlags fromDate:self];
    NSUInteger weekDay = [comps weekday];
    return (int)weekDay;
}

- (NSUInteger)numberOfDaysInCurrentMonth {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (int)firstWeekDayInMonth {
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:1];
    
    NSDateComponents* comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [comps setDay:1];
    NSDate* newDate = [gregorian dateFromComponents:comps];
    
    return (int)(8 - [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate]);
}

- (NSUInteger)numberOfWeeksInCurrentMonth {
    NSUInteger weeks = 0;
    NSUInteger weekday = [self firstWeekDayInMonth];
    if (weekday > 0) {
        weeks += 1;
    }
    NSUInteger monthDays = [self numberOfDaysInCurrentMonth];
    weeks = weeks + (monthDays - weekday) / 7;
    if ((monthDays - weekday) % 7 > 0) {
        weeks += 1;
    }
    return weeks;
}

- (NSDate*)lastMonthDate:(NSDate *)date {
    NSCalendar* gregorian = [NSCalendar currentCalendar];
    NSDateComponents* comps = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:date];
    if (comps.month == 1) {
        [comps setMonth:12];
        [comps setYear:comps.year - 1];
    } else {
        [comps setMonth:comps.month - 1];
    }
    return [gregorian dateFromComponents:comps];
}

- (NSDate*)nextMonthDate:(NSDate *)date {
    NSCalendar* gregorian = [NSCalendar currentCalendar];
    NSDateComponents* comps = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:date];
    if (comps.month == 12) {
        [comps setMonth:1];
        [comps setYear:comps.year + 1];
    } else {
        [comps setMonth:comps.month + 1];
    }
    return [gregorian dateFromComponents:comps];
}

@end

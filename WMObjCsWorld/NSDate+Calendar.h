//
//  NSData+Calendar.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/15.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

/**
 * @return 当前日期的年
 */
- (int)year;

/**
 * @return 当前日期的月
 */
- (int)month;

/**
 * @return 当前日期的日
 */
- (int)day;

/**
 * @return 当前日期的时
 */
- (int)hour;

/**
 * @return 当前日期的分
 */
- (int)minute;

/**
 * @return 当前日期的秒
 */
- (int)second;

/**
 * @return 当前日期在一周中的天数, 周日 ~ 周六 1 ~ 7
 */
- (int)dayOfWeek;

/**
 * @return 当前月有多少天
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 * @return 当前月的第一个星期有几天
 */
- (int)firstWeekDayInMonth;

/**
 * @return 一个月有几周
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**
 * @param date : 对比日期
 * @return 对比日期的上一个月的日期
 */
- (NSDate*)lastMonthDate:(NSDate*)date;

/** 
 * @param date : 对比日期
 * @return 对比日期的下一个月的日期
 */
- (NSDate*)nextMonthDate:(NSDate*)date;

/**
 * @brief 根据当前日期, 返回其所在的星座
 */
- (NSString*)constellation;

+ (NSString*)constellationFromDate:(NSDate*)date;

- (BOOL)isToday;

@end

//
//  ViewController.m
//  TestDemo
//
//  Created by 千铭 on 2017/6/15.
//  Copyright © 2017年 千铭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray ;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    self.dataArray = [NSMutableArray array];
    //前推3周，21天日期数据集合
    NSMutableArray *forward = [self getForwardDataArr:21];
    for (NSInteger i=0; i<forward.count; i++) {
        [self.dataArray addObject:forward[i]];
    }
    //当前日期数据集合
    NSMutableArray *current = [self getForwardDataArr:0];
    for (NSInteger i=0; i<current.count; i++) {
//        [dataArray addObject:current[i]];
        
        [self.dataArray addObject:[NSString stringWithFormat:@"%@\n%@",@"今天",current[i]]];

    }
    //后推一周，7天日期数据集合
    NSMutableArray *backward = [self getBackwardDataArr:7];
    for (NSInteger i=0; i<backward.count; i++) {
        [self.dataArray addObject:backward[i]];
    }
    
    for (int i=0; i<self.dataArray.count; i++) {
        NSLog(@"%@",self.dataArray[i]);
        //正数22，倒数8为今天日期
    }
    
    
    NSLog(@"今天---%@",self.dataArray[21]);


}

//获取几天后的日期集合
- (NSMutableArray *)getBackwardDataArr:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    if (index>0) {
        for (NSInteger i=0; i<index; i++) {
            NSDate *date = [self getOneDay:i+1];
            NSString *ymdString = [self getYearMonthDayWeekWithDate:date];
            [array addObject:ymdString];
        }
    }else{
        NSDate *date = [self getOneDay:index];
        NSString *ymdString = [self getYearMonthDayWeekWithDate:date];
        [array addObject:ymdString];
    }
    
    return array;
}

//获取几天前的日期集合
- (NSMutableArray *)getForwardDataArr:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    if (index>0) {
        for (NSInteger i=index; i>0; i--) {
            NSDate *date = [self getOneDay:-i];
            NSString *ymdString = [self getYearMonthDayWeekWithDate:date];
            [array addObject:ymdString];
        }
    }else{
        NSDate *date = [self getOneDay:index];
        NSString *ymdString = [self getYearMonthDayWeekWithDate:date];
        [array addObject:ymdString];
    }
    
    return array;
}

//根据日期获取年月日周
- (NSString *)getYearMonthDayWeekWithDate:(NSDate *)date
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"yyy"];
//    NSString *  yearString = [dateformatter stringFromDate:date];
    [dateformatter setDateFormat:@"MM"];
    NSString *  monthString = [dateformatter stringFromDate:date];
    [dateformatter setDateFormat:@"dd"];
    NSString *  dayString = [dateformatter stringFromDate:date];
    [dateformatter setDateFormat:@"EEE"];
    [dateformatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString *weekString = [dateformatter stringFromDate:date];
    
//    return [NSString stringWithFormat:@"%@-%@-%@",monthString,dayString,weekString];

    
    return [NSString stringWithFormat:@"%@\n%@/%@",weekString,monthString,dayString];
    
//    return [NSString stringWithFormat:@"%@-%@-%@-%@",yearString,monthString,dayString,weekString];
}

/**
 *  获取几年几月几日后的日期，0表示当天，负数表示之前
 *  这里只要取到日就好了，年月置0，表示当年当月
 */
- (NSDate *)getOneDay:(NSInteger)day {
    NSInteger year = 0, month = 0;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    return newdate;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

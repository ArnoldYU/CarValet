//
//  YearEditViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/3/2.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "YearEditViewController.h"
#import "Car.h"

@interface YearEditViewController ()

@end

@implementation YearEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    NSInteger yearValue = [self.delegate editYearValue];
    
    if (yearValue == kModelTYear) {
        yearValue = [self getYearFromDate:[NSDate date]];
    }
    
    NSInteger rows = [self.editPicker numberOfRowsInComponent:0];
    NSInteger maxYear = (kModelTYear + rows) - 1;
    NSInteger row = maxYear -yearValue;
    
    [self.editPicker selectRow:row inComponent:0 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger maxYear = [self getYearFromDate:[NSDate date]];
    
    maxYear += 1;
    
    return (maxYear - kModelTYear);
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    NSInteger totalRows = [pickerView numberOfRowsInComponent:component];
    
    NSInteger displayVal = ((kModelTYear + totalRows) - 1) -row;
    
    return [NSString stringWithFormat:@"%d", displayVal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)getYearFromDate:(NSData*)theDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//1 年份要求将日期分解为组件，这需要有日历。该方法只针对罗马日了，虽然可以使用当前系统日历来对返回的值进行本地化
    
    NSDateComponents *components;
    
    components = [gregorian components:NSYearCalendarUnit fromDate:theDate];//2 从theDate返回日期的一个组件对象，用于初始化年份
    
    return components.year; //3 返回日期组件
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editDone:(id)sender {
    NSInteger rows = [self.editPicker numberOfRowsInComponent:0];
    NSInteger maxYear = (kModelTYear + rows) -1;
    NSInteger year = maxYear - [self.editPicker selectedRowInComponent:0];
    
    [self.delegate editYearDone:year];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

//
//  CarEditViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/20.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import "CarEditViewController.h"
#import "Car.h"

@interface CarEditViewController ()

@end

@implementation CarEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *labelFormat = @"%@:";//为标签设置默认的格式字符串，其中包含分隔符。这允许后续使用NSlocalizedString宏来对格式字符串进行本地化
    NSString *local;//设置一个临时变量，用于存储指向每一个本地化字符串对象的指针，然后设置UI元素要显示的字符串。可以跳过使用变量，将接卖弄字符串设置为调用NSLocalizedStringWithDefaultValue的返回值
    
    //格式化所有标签
    local = NSLocalizedStringWithDefaultValue(@"CarMakeFieldLabel", nil, [NSBundle mainBundle], @"Make", "Label for the line to enter or edit the Make of a car");
    self.CarMakeFieldLabel.text = [NSString stringWithFormat:labelFormat,local];
    local = NSLocalizedStringWithDefaultValue(@"CarModelFieldLabel", nil, [NSBundle mainBundle], @"Model", @"Label for the line to enter or edit the Model of a car");
    self.CarModelFieldLabel.text = [NSString stringWithFormat:labelFormat,local];
    local = NSLocalizedStringWithDefaultValue(@"CarYearFieldLabel", nil, [NSBundle mainBundle], @"Year", @"Label for the line to enter or edit the Year of a car");
    self.CarYearFieldLabel.text = [NSString stringWithFormat:labelFormat,local];
    local = NSLocalizedStringWithDefaultValue(@"CarFuelFieldLabel", nil, [NSBundle mainBundle], @"Fuel", @"Label for the line to enter or edit the Fuel of a car");
    self.CarFuelFieldLabel.text = [NSString stringWithFormat:labelFormat,local];
    NSString *carNumberText;
    //格式化Car Number标签。与Add/View场景使用相同的键
    carNumberText = [NSString stringWithFormat:@"%@: %ld",
                     NSLocalizedString(@"CarNumberLabel", @"Label for the index number of the current car"),(long)[self.delegate carNumber]];
    self.carNumberLabel.text = carNumberText;
    
    self.currentCar = [self.delegate carToEdit];
    self.makeField.text = self.currentCar.make;
    self.modelField.text = self.currentCar.model;
    self.yearField.text = [NSString stringWithFormat:@"%d",self.currentCar.year];
    self.fuelField.text = [NSString stringWithFormat:@"%0.2f",self.currentCar.fuelAmount];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.currentCar.make = self.makeField.text;
    self.currentCar.model = self.modelField.text;
    self.currentCar.year = [self.yearField.text integerValue];
    self.currentCar.fuelAmount = [self.fuelField.text floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.delegate editedCarUpdated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EditDoneSegue"]){
        self.currentCar.make = self.makeField.text;
        self.currentCar.model = self.modelField.text;
        self.currentCar.year = [self.yearField.text integerValue];
        self.currentCar.fuelAmount = [self.fuelField.text floatValue];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

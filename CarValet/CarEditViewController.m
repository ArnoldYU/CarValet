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

@implementation CarEditViewController{
    CGFloat defaultScrollViewHeightConstraint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
    defaultScrollViewHeightConstraint = self.scrollviewHeightConstraints.constant;
    
    self.formView.translatesAutoresizingMaskIntoConstraints = YES;//1
    [self.scrollView addSubview:self.formView];//2
    self.formView.frame = CGRectMake(0.0, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);//3
    self.scrollView.contentSize = self.formView.bounds.size;//4
    
    
    self.title = NSLocalizedStringWithDefaultValue(@"EditViewScreenTitle", nil, [NSBundle mainBundle], @"Edit Car", @"Title of EditView");
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
    carNumberText = [NSString localizedStringWithFormat:@"%@: %ld",
                     NSLocalizedString(@"CarNumberLabel", @"Label for the index number of the current car"),(long)[self.delegate carNumber]];
    self.carNumberLabel.text = carNumberText;
    
    self.currentCar = [self.delegate carToEdit];
    self.makeField.text = self.currentCar.make;
    self.modelField.text = self.currentCar.model;
    self.yearField.text = [NSString localizedStringWithFormat:@"%d",self.currentCar.year];
    self.fuelField.text = [NSString localizedStringWithFormat:@"%0.2f",self.currentCar.fuelAmount];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardDidShowNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIKeyboardWillHideNotification
                                                 object:nil];
    
    self.currentCar.make = self.makeField.text;
    self.currentCar.model = self.modelField.text;
    
    NSNumberFormatter *readYear = [NSNumberFormatter new];
    readYear.locale = [NSLocale currentLocale];
    [readYear setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *YearNum = [readYear numberFromString:self.yearField.text];
    self.currentCar.year = (int)[YearNum integerValue];
    
    NSNumberFormatter *readFuel = [NSNumberFormatter new];
    readFuel.locale = [NSLocale currentLocale];
    [readFuel setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *fuelNum = [readFuel numberFromString:self.fuelField.text];
    self.currentCar.fuelAmount = [fuelNum floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.delegate editedCarUpdated];
}

- (void)keyboardDidShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];//1
    NSValue *aValue = userInfo[UIKeyboardIsLocalUserInfoKey];//2
    CGRect keyboardRect = [aValue CGRectValue];//3
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGRect intersect = CGRectIntersection(self.scrollView.frame, keyboardRect);//4
    self.scrollviewHeightConstraints.constant -= intersect.size.height;//5
    [self.view updateConstraints];//6
    self.scrollView.contentSize = self.formView.frame.size;
}

- (void)keyboardWillHide:(NSNotification *)notification{//7
    self.scrollviewHeightConstraints.constant = defaultScrollViewHeightConstraint;
    [self.view updateConstraints];
    self.scrollView.contentSize = self.formView.frame.size;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EditDoneSegue"]){
        self.currentCar.make = self.makeField.text;
        self.currentCar.model = self.modelField.text;
        
        NSNumberFormatter *readYear = [NSNumberFormatter new];
        readYear.locale = [NSLocale currentLocale];
        [readYear setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *YearNum = [readYear numberFromString:self.yearField.text];
        self.currentCar.year = [YearNum integerValue];
        
        NSNumberFormatter *readFuel = [NSNumberFormatter new];
        readFuel.locale = [NSLocale currentLocale];
        [readFuel setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *fuelNum = [readFuel numberFromString:self.fuelField.text];
        self.currentCar.fuelAmount = [fuelNum floatValue];
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

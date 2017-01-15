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
    
    self.formView.translatesAutoresizingMaskIntoConstraints = YES;//1 该框架视图不具有任何相对于父视图的约束。让系统使用其当前边框创建约束
    [self.scrollView addSubview:self.formView];//2 将表单视图添加到滚动视图
    self.formView.frame = CGRectMake(0.0, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);//3确保表单视图和滚动视图一样宽
    self.scrollView.contentSize = self.formView.bounds.size;//4根据需要设置滚动视图的contenSize属性
    
    
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
    NSDictionary *userInfo = [notification userInfo];//1获取与通知相关联的信息字典
    NSValue *aValue = userInfo[UIKeyboardIsLocalUserInfoKey];//2查找显示的键盘的最终视图边框
    CGRect keyboardRect = [aValue CGRectValue];//3将最终视图边框的值转为CGRect，并将坐标空间从设备主窗口转换为查看汽车分组使用的坐标系，也就是说，转换到编辑场景视图控制器的根视图的坐标系
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGRect intersect = CGRectIntersection(self.scrollView.frame, keyboardRect);//4找到由滚动视图和键盘的交集定义的矩形。如果滚动视图和键盘不重叠，矩形是全0
    printf("%f\n",intersect.size.height);
    self.scrollviewHeightConstraints.constant = defaultScrollViewHeightConstraint-0.5*intersect.size.height;//5降低滚动视图的高度，者通过减少垂直的重叠量来完成，也就是相交的矩形的高度。
    [self.view updateConstraints];//6因为滚动视图的高度常量可能已经发生改变，更新约束
    self.scrollView.contentSize = self.formView.frame.size;
}

- (void)keyboardWillHide:(NSNotification *)notification{//7当键盘关闭时，将高度约束设置为默认值，并更新约束
    printf("1:%f/n",defaultScrollViewHeightConstraint);
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
        self.currentCar.year = (int)[YearNum integerValue];
        
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

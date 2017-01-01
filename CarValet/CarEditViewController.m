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
    // Do any additional setup after loading the view.
    NSString *carNumberText;
    carNumberText = [NSString stringWithFormat:@"Car Number:%ld",(long)[self.delegate carNumber]];
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

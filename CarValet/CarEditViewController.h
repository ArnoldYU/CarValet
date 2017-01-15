//
//  CarEditViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/20.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarEditViewControllerProtocol.h"

@class Car;

@interface CarEditViewController : UIViewController
//
//@property (nonatomic) NSInteger carNumber;

@property (weak, nonatomic) id <CarEditViewControllerProtocol> delegate;

@property (strong,nonatomic) Car *currentCar;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarMakeFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarModelFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarYearFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarFuelFieldLabel;
@property (weak, nonatomic) IBOutlet UITextField *makeField;
@property (weak, nonatomic) IBOutlet UITextField *modelField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *fuelField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeightConstraints;


@end

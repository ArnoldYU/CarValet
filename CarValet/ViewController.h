//
//  ViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/12.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarEditViewControllerProtocol.h"

@interface ViewController : UIViewController

<CarEditViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *totalCarsLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousCarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextCarButton;
- (IBAction)aboutCarValet:(id)sender;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *addCarViewPortraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *separatorViewPortraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rootViewPortraitConstraints;

- (IBAction)newCar:(id)sender;
- (IBAction)previousCar:(id)sender;
- (IBAction)nextCar:(id)sender;

@end


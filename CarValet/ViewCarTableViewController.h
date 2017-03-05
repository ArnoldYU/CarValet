//
//  ViewCarTableViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeModelEditProtocol.h"
#import "YearEditProtocol.h"
#import "ViewCarProtocol.h"
@class Car;
@interface ViewCarTableViewController : UITableViewController
<MakeModelEditProtocol, UINavigationControllerDelegate,YearEditProtocol>

@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property Car *myCar;
@property (weak, nonatomic) id <ViewCarProtocol> delegate;
@end

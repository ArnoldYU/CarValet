//
//  CarTableViewCell.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDCar;
@interface CarTableViewCell : UITableViewCell

@property (strong, nonatomic) CDCar *myCar;

- (void)configureCell;
@end

//
//  CarTableViewCell.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "CarTableViewCell.h"
#import "CDCar+CoreDataProperties.h"
@implementation CarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell {
    NSString *make = (self.myCar.make == nil) ? @"Unknown" : self.myCar.make;//1 汽车的make或model可能为nil，所以将其设置为默认值
    NSString *model = (self.myCar.model == nil) ? @"Unknown" : self.myCar.model;
    self.textLabel.text = [NSString stringWithFormat:@"%d %@ %@",self.myCar.year,make,model];//2 将主编前设置为汽车的year、make和model
    
    NSString *dateStr = [NSDateFormatter localizedStringFromDate:self.myCar.dateCreated
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterShortStyle];//3 获得本地化版本的创建日期，日期样式应尽可能简短
    NSLog(@"%@", self.myCar.dateCreated);
    self.detailTextLabel.text = dateStr;//4 将段版本的创建日期设置到详细信息文本去中
}
@end

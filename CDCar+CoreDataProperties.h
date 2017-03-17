//
//  CDCar+CoreDataProperties.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/3/16.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "CDCar+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CDCar (CoreDataProperties)

+ (NSFetchRequest<CDCar *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nonatomic) int16_t year;
@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, copy) NSString *make;
@property (nonatomic) float fuelAmount;

@end

NS_ASSUME_NONNULL_END

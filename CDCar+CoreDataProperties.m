//
//  CDCar+CoreDataProperties.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/3/16.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "CDCar+CoreDataProperties.h"

@implementation CDCar (CoreDataProperties)

+ (NSFetchRequest<CDCar *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CDCar"];
}

@dynamic dateCreated;
@dynamic year;
@dynamic model;
@dynamic make;
@dynamic fuelAmount;

@end

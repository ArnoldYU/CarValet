//
//  Car.h
//  CarValet
//
//  Created by XXX on 2016/12/12.
//  Copyright © 2016年 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject {
    int _year;
    NSString *_make;
    NSString *_model;
    float _fuleAmount;
}

@property int year;
@property NSString *make;
@property NSString *model;
@property float fuelAmount;
@property NSDate* dateCreated;

- (id)initWithMake:(NSString*)make
            model:(NSString*)model
             year:(int)year
       fuelAmount:(float)fuelAmount;

@property (readonly) NSString *carInfo;

- (void)printCarInfo;


@end

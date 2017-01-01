//
//  Car.m
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/12.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import "Car.h"

@implementation Car

- (id)init {
    //在超类（NSObject）上调用init方法，这保证了NSObject要求的任何初始化逻辑，在特定于Car类的初始化逻辑之前执行完毕
    self = [super init];
    if (self != nil) {//确保self实际已经初始化了，如果已经初始化了，这个对象的剩余部分将被创建
        _year = 1900;//默认值设置为1900
        _fuleAmount = 0.0f;//默认值设置为0.0f。这里的f可以去掉，但是这是为了告诉编译器这是fload值，而不是其他类型的浮点值，建议写
    }
    return self;//返回self
    //到此为止，Car对象已经被初始化了
}

- (id)initWithMake:(NSString *)make//分配新的对象，然后将每个值传入Car对象的属性中
            model:(NSString *)model
             year:(int)year
       fuelAmount:(float)fuelAmount {
    
    self = [super init];//首先调用初类的初始化。如果成功，初始化对象的剩余部分；失败，返回nil
    if (self !=nil) {
        _make = [make copy];//为Car对象设置所有实例变量
        _model = [model copy];
        _year = year;
        _fuleAmount = fuelAmount;
    }
    return self;
}

//- (void)printCarInfo {//打印信息，当_make和_model不为空的时候才能打印（空的时候就是初始化没有啥意义打印也是白打）
//    if (!_make) return;
//    if (!_model) return;
//    //NSlog是想控制台打印的方法
//    NSLog(@"Car Make: %@",_make);
//    NSLog(@"Car Model: %@",_model);
//    NSLog(@"Car Year:%d",_year);
//    NSLog(@"Number of Gallons in Tank: %0.2f",_fuleAmount);
//}
- (void)printCarInfo {
    if (self.make && self.model) {
        NSLog(@"Car Make: %@",self.make);
        NSLog(@"Car Model: %@",self.model);
        NSLog(@"Car Year:%d",self.year);
        NSLog(@"Number of Gallons in Tank: %0.2f",self.fuelAmount);
    } else {
        NSLog(@"Car undefined: no make or model specified");
    }
}

- (NSString *)carInfo {
    return [NSString stringWithFormat:
            @"Car Info\n Make: %@\n Model: %@\n year: %d",self.make ? self.make :@"Unknown Make",self.model ? self.model :@"Unknown Model",self.year];
}
@end


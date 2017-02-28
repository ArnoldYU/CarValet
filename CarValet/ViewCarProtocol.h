//
//  ViewCarProtocol.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/28.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@protocol ViewCarProtocol <NSObject>

- (Car*)carToView;

- (void)carViewDone: (BOOL)dataChanged;

@end

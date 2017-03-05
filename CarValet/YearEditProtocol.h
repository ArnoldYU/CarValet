//
//  YearEditProtocol.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/3/5.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YearEditProtocol <NSObject>

- (NSInteger) editYearValue;

- (void) editYearDone:(NSInteger)yearValue;


@end

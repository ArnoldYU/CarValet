//
//  CarEditViewControllerProtocol.h
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/26.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import <Foundation/Foundation.h>//在协议中个导入用到的类的所有头文件。Foundation.h定义了许多Cocoa类型，包括NSInteger类型

@class Car;

@protocol CarEditViewControllerProtocol <NSObject>//@protocol是声明协议的指令。接下来的部分是协议的名称，接着是协议要包含的内容。在这种情况下，CarEditViewControllerProtocol有权限访问任何在NSObject协议中声明的方法，如self、class和description等

- (Car*)carToEdit;//指定方法声明的方式如同公共类方法

- (NSInteger)carNumber;

- (void)editedCarUpdated;

@end

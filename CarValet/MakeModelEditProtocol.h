//
//  MakeModelEditProtocol.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/28.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MakeModelEditProtocol <NSObject>

- (NSString*)titleText;

- (NSString*)editLabelText;

- (NSString*)editFieldText;

- (NSString*)editFieldPlaceholderText;

- (void)editDone:(NSString*)textFieldValue;
@end

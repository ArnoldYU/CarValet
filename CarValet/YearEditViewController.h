//
//  YearEditViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/3/2.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearEditProtocol.h"

@interface YearEditViewController : UIViewController

<UIPickerViewDelegate,UIPickerViewDataSource>


- (IBAction)editCancel:(id)sender;
- (IBAction)editDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *editPicker;

@property (weak, nonatomic) id <YearEditProtocol> delegate;



@end

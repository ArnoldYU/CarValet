//
//  MakeModelEditViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeModelEditProtocol.h"
@interface MakeModelEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *editLabel;
@property (weak, nonatomic) IBOutlet UITextField *editField;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavigationItem;
- (IBAction)editCancel:(id)sender;
- (IBAction)editDone:(id)sender;

@property (weak, nonatomic) id <MakeModelEditProtocol> delegate;
@end

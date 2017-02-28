//
//  MakeModelEditViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "MakeModelEditViewController.h"

@interface MakeModelEditViewController ()

@end

@implementation MakeModelEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNavigationItem.title = [self.delegate titleText];
    
    self.editLabel.text = [self.delegate editLabelText];
    self.editField.text = [self.delegate editFieldText];
    self.editField.placeholder = [self.delegate editFieldPlaceholderText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editDone:(id)sender {
    [self.delegate editDone:self.editField.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

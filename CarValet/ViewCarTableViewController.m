//
//  ViewCarTableViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "ViewCarTableViewController.h"
#import "MakeModelEditViewController.h"
#import "YearEditViewController.h"
#include "Car.h"

#define kCurrentEditMake 0
#define kCurrentEditModel 1
@interface ViewCarTableViewController () {
    NSInteger currentEdutType;
    BOOL dataUpdated;
}

@end

@implementation ViewCarTableViewController

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == (UIViewController*)self.delegate) {
        if (dataUpdated) {
            [self.delegate carViewDone:dataUpdated];
        }
        
        navigationController.delegate = nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MakeEditSegue"]) {
        MakeModelEditViewController *nextController;
        nextController = segue.destinationViewController;
        nextController.delegate = self;
        currentEdutType = kCurrentEditMake;
    } else if ([segue.identifier isEqualToString:@"ModelEditSegue"]) {
        MakeModelEditViewController *nextController;
        nextController = segue.destinationViewController;
        nextController.delegate = self;
        currentEdutType = kCurrentEditModel;
    } else if ([segue.identifier isEqualToString:@"YearEditSegue"]) {
        YearEditViewController *nextController;
        nextController = segue.destinationViewController;
        
        nextController.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataUpdated = NO;
    self.myCar = [self.delegate carToView];
    self.makeLabel.text = (self.myCar.make == nil) ? @"Unknown" : self.myCar.make;
    self.modelLabel.text = (self.myCar.model == nil) ? @"Unknown" : self.myCar.model;
    self.yearLabel.text = [NSString stringWithFormat:@"%d",self.myCar.year];
    self.fuelLabel.text = [NSString stringWithFormat:@"%0.2f",self.myCar.fuelAmount];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:self.myCar.dateCreated
                                                         dateStyle:NSDateFormatterMediumStyle
                                                         timeStyle:NSDateFormatterNoStyle];
    self.timeLabel.text = [NSDateFormatter localizedStringFromDate:self.myCar.dateCreated
                                                         dateStyle:NSDateFormatterNoStyle
                                                         timeStyle:NSDateFormatterMediumStyle];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)editYearValue {
    return self.myCar.year;
}

- (void)editYearDone:(NSInteger)yearValue {
    if(yearValue != self.myCar.year) {
        self.myCar.year = yearValue;
        
        self.yearLabel.text = [NSString stringWithFormat:@"%d",self.myCar.year];
        
        dataUpdated = YES;
    }
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSString*)titleText {
    NSString *titleString = @"";
    
    switch (currentEdutType) {
        case kCurrentEditMake:
            titleString = @"Make";
            break;
        case kCurrentEditModel:
            titleString = @"Model";
            break;
        default:
            break;
    }
    return titleString;
}

- (NSString*)editLabelText {
    NSString *titleString = @"";
    
    switch (currentEdutType) {
        case kCurrentEditMake:
            titleString = @"Enter the Make:";
            break;
        case kCurrentEditModel:
            titleString = @"Enter the Model:";
            break;
        default:
            break;
    }
    return titleString;
}

- (NSString*)editFieldText {
    NSString *titleString = @"";
    
    switch (currentEdutType) {
        case kCurrentEditMake:
            titleString = self.myCar.make;
            break;
        case kCurrentEditModel:
            titleString = self.myCar.model;
            break;
        default:
            break;
    }
    return titleString;
}

- (NSString*)editFieldPlaceholderText {
    NSString *titleString = @"";
    
    switch (currentEdutType) {
        case kCurrentEditMake:
            titleString = @"Car Make";
            break;
        case kCurrentEditModel:
            titleString = @"Car Model";
            break;
        default:
            break;
    }
    return titleString;
}

- (void)editDone:(NSString*)textFieldValue {
    if(textFieldValue != nil && [textFieldValue length] > 0) { //1 仅当有新的文本时才更新。如果文本框一开始根据editFieldText设置为nil，而且现在仍然是nil，那么不做任何改变。它也可以是一个空字符串
        switch (currentEdutType) {
            case kCurrentEditMake:
                if (self.myCar.make == nil || !([self.myCar.make isEqualToString:textFieldValue])) { //2 文本框中有一些文字，如果当前没有值或者新值与旧值不同，则更新
                    self.myCar.make = textFieldValue; //3 如果有更新，则修改Car对象
                    
                    self.makeLabel.text = textFieldValue; // 4 在汽车视图中修改标签
                    
                    dataUpdated = YES;
                }
                break;
            
            case kCurrentEditModel:
                if (self.myCar.model == nil || !([self.myCar.model isEqualToString:textFieldValue])) {
                    self.myCar.model = textFieldValue;
                    
                    self.modelLabel.text = textFieldValue;
                    
                    dataUpdated = YES;
                }
            default:
                break;
        }
    }
    
}
@end

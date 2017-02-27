//
//  CarTableViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/2/27.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "CarTableViewController.h"
#import "ViewCarTableViewController.h"
#import "Car.h"
#import "CarTableVIewCell.h"

@interface CarTableViewController ()

@end

@implementation CarTableViewController{
    NSMutableArray *arrayOfCars;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ViewSegue"]) {
        ViewCarTableViewController *nextController;
        nextController = segue.destinationViewController;
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        nextController.myCar = arrayOfCars[index];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfCars = [NSMutableArray new];
    
    [self newCar:nil];
    self.navigationItem.leftBarButtonItem = self.editButton;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [arrayOfCars count];
}

- (IBAction)newCar:(id)sender {
    Car *newCar = [Car new];
    
    [arrayOfCars insertObject:newCar atIndex:0];//1 将汽车插入到数组的前边
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];//2 创建一个NSindexPath对象来指定新单元格的位置——他的section和row
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//3 让表视图在新的索引路径上插入一个对象。这回事表视图调用数据源来查找第0表格段第0行的数据——也就是数组的第一个元素。因为数组已经被更新，所以新的单元格会被返回
    //[self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CarCell";
    
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.myCar = arrayOfCars[indexPath.row];
    [cell configureCell];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [arrayOfCars removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}


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

- (IBAction)editTableView:(id)sender {
    BOOL startEdit = (sender == self.editButton); //1 如果发送这条消息的是编辑按钮，那么开始编辑
    
    UIBarButtonItem *nextButton = (startEdit) ? self.doneButton :self.editButton; //2 下一个要显示的按钮是当前没有显示的那个，就是交替出现done和edit
    
    [self.navigationItem setLeftBarButtonItem:nextButton animated:YES];//3为新的导航栏按钮添加动画
    [self.tableView setEditing:startEdit animated:YES];//4让表视图动画过度到编辑或非编辑状态
}
@end

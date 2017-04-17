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
#import "CarTableViewCell.h"
#import "AppDelegate.h"
#import "CDCar+CoreDataProperties.h"
#import <CoreData/CoreData.h>

@interface CarTableViewController ()

<ViewCarProtocol,NSFetchedResultsControllerDelegate>

@end

@implementation CarTableViewController{
//    NSArray *arrayOfCars;
    NSIndexPath *currentViewCarPath;
    NSManagedObjectContext *managedContextObject;
    NSFetchRequest *fetchRequest;
    NSFetchedResultsController *fetchedResultsController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ViewSegue"]) {
        
        ViewCarTableViewController *nextController;
        nextController = segue.destinationViewController;
//        NSInteger index = [self.tableView indexPathForSelectedRow].row;
//        nextController.myCar = arrayOfCars[index];
        nextController.delegate = self;
    }
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
//    
//    managedContextObject = appDelegate.managedObjectContext;
//    NSError *error=nil;
//    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CDCar"];//1 创建查找类CDCar的所有实体的抓取请求。其他方法和属性可用于添加过滤、排序，甚至批量加载对象
//    arrayOfCars = [managedContextObject executeFetchRequest:fetchRequest error:&error];//2将汽车数组设置为上下文中所有符合抓取请求标准的托管对象——在此处为所有汽车
//    
//    if (error != nil) {
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]); //3 读取对象时出错。将日志打印到文件对学习游泳。但更好的办法是如果个能的话，尽力从错误中恢复；如果无法恢复的话，将当前情况通知用户并告诉用户可以尝试的解决办法
//        abort();//4对abourt()的调用来自系统提供的模板。它所做的所有事情就是创建崩溃日志并且终止程序
//    }
//    
//    self.navigationItem.leftBarButtonItem = self.editButton;
//    
////    arrayOfCars = [NSMutableArray new];
////    
////    [self newCar:nil];
////    self.navigationItem.leftBarButtonItem = self.editButton;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    managedContextObject = appDelegate.managedObjectContext;
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CDCar"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"dateCreated"
                                        ascending:NO];//1在创建时创建一条简单的排序规则，将最新的数据显示在顶部

    [fetchRequest setSortDescriptors:@[sortDescriptor]];//2将抓取请求的爱须描述符设置为这条新的排序规则。注意必须将排序描述符设置为描述符数组，即使只有一个。这就是这条语句使用@[]数组字面构造器的原因
    fetchedResultsController = [[NSFetchedResultsController alloc]//3从应用程序委托中，初始化使用刚刚分配的抓取请求结果控制器以及托管对象上下文。只有一个表格段，因此不需要表格段名称。也没有缓存
                                initWithFetchRequest:fetchRequest
                                managedObjectContext:managedContextObject
                                sectionNameKeyPath:nil
                                cacheName:nil];
    fetchedResultsController.delegate = self;
    NSError *error=nil;
    [fetchedResultsController performFetch:&error];//4让控制器读取初始数据集，并且处理仍可能发生的错误

    if (error!=nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    self.navigationItem.leftBarButtonItem = self.editButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    return 1;
    return [[fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return [arrayOfCars count];
    id <NSFetchedResultsSectionInfo> sectionInfo;
    sectionInfo = [fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (IBAction)newCar:(id)sender {
    
    CDCar *newCar=[NSEntityDescription insertNewObjectForEntityForName:@"CDCar"
                                                inManagedObjectContext:managedContextObject];//1 在当前的托管对象上下文中创建新的汽车对象
    
    newCar.dateCreated = [NSDate date];//2初始化汽车的创建日期
    
    NSError *error;
//    arrayOfCars = [managedContextObject executeFetchRequest:fetchRequest
//                                                      error:&error];//3重新生成当前的汽车数组，已包含新的汽车对象
//    [fetchedResultsController performFetch:&error];
    [managedContextObject save:&error];
    if(error != nil) {
        NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
        abort();
    }
    
//    Car *newCar = [Car new];
//    
//    [arrayOfCars insertObject:newCar atIndex:0];//1 将汽车插入到数组的前边
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];//2 创建一个NSindexPath对象来指定新单元格的位置——他的section和row
//    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//3 让表视图在新的索引路径上插入一个对象。这回事表视图调用数据源来查找第0表格段第0行的数据——也就是数组的第一个元素。因为数组已经被更新，所以新的单元格会被返回
//    //[self.tableView reloadData];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(nullable NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(nullable NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch (type) {//1基于修改的类型，确定需要做哪一种更新
        case NSFetchedResultsChangeInsert://2档新对象插入之后，在表格中的恰当位置插入一个单元格
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete://3一个对象被删除，因此删除相应的单元格
            [tableView deleteRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
//        case NSFetchedResultsChangeUpdate://4这类修改在对象被修改或更新时发生。在此处，我们需要做刷新表示数据的单元格所需要做的一切事情
//            code to update the content of the cell at indexPath
//            break;
//        case NSFetchedResultsChangeMove://5最后一处修改是将数据单元格从表格中的一个地方一道另一个地方。通常这意味着删除旧的单元格并插入一个新的
//            [tableView deleteRowsAtIndexPaths:@[indexPath]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:@[newIndexPath]
//                             withRowAnimation:UITableViewRowAnimationFade];
//            break;
            
        default:
            break;
    }
}
- (CDCar *)carToView {
//    NSInteger index = [self.tableView indexPathForSelectedRow].row;
    currentViewCarPath = [self.tableView indexPathForSelectedRow];
    
//    return arrayOfCars[index];
//    return arrayOfCars[currentViewCarPath.row];
    return [fetchedResultsController objectAtIndexPath:currentViewCarPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CarCell";
    
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell.myCar = arrayOfCars[indexPath.row];
    cell.myCar = [fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCell];
    
    return cell;
}

- (void)carViewDone:(BOOL)dataChanged {
//    if (dataChanged) {
//        [self.tableView reloadData];
//    }
    if (dataChanged) {
        [self.tableView reloadRowsAtIndexPaths:@[currentViewCarPath] withRowAnimation:YES];
    }
    currentViewCarPath = nil;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [managedContextObject deleteObject:arrayOfCars[indexPath.row]];//1让托管对象上下文来删除CDCar对象
//        [managedContextObject deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
//        arrayOfCars = [managedContextObject executeFetchRequest:fetchRequest error:&error];
        [fetchedResultsController performFetch:&error];
        
        if(error != nil) {
            NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
            abort();
        }
    } //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

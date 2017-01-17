//
//  ViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/12.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "CarEditViewController.h"
#import "AboutViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *arrayOfCars; //使用mutable array记录所有汽车对象
    NSInteger displayedCarIndex; //指定靠下位置显示的汽车的数组索引
    NSArray *separatorViewLandscapeConstraints;
    NSArray *addCarViewLandscapeConstraints;
    NSArray *rootViewLandscapeConstraints;
    BOOL isShowingPortrait;
    __weak IBOutlet UIView *addCarView;
    __weak IBOutlet UIView *separatorView;
    __weak IBOutlet UIView *viewCarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *sky = [UIColor colorWithDisplayP3Red:102.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.navigationController.toolbar.barTintColor = sky;
       
    
    self.navigationController.toolbarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = NSLocalizedStringWithDefaultValue(@"AddViewScreenTitle", nil, [NSBundle mainBundle], @"CarValet", "Title for the main app screen");

    NSString *local;//为当前的本地化标题设置临时字符串引用
    
    //将这个临时字符串设置为Add Car按钮的本地化标题
    local = NSLocalizedStringWithDefaultValue(@"NewCarButton", nil, [NSBundle mainBundle], @"New Car", @"Button to create and add a new car");
    [self.addCarButton setTitle:local forState:UIControlStateNormal];//将Add Car按钮在默认状态下的标题设置为这个本地化字符串
    
    local = NSLocalizedStringWithDefaultValue(@"TotalNumber", nil, [NSBundle mainBundle], @"Total Car", @"total car");
    self.totalCarsLabel.text = local;
    local = NSLocalizedStringWithDefaultValue(@"CurrentNumber", nil, [NSBundle mainBundle], @"Current Car", @"Current car");
    self.CarNumberLabel.text = local;
    local = NSLocalizedStringWithDefaultValue(@"CarInfor", nil, [NSBundle mainBundle], @"CarInfor", @"CarInfor");
    self.CarInfoLabel.text = local;
    arrayOfCars = [[NSMutableArray alloc] init];//初始化汽车的数组为空数组
    displayedCarIndex = 0;//显示创建的第一辆汽车
    [self setupLandscapeConstraints];
    UIInterfaceOrientation currOrientation = [[UIApplication sharedApplication]statusBarOrientation];
    isShowingPortrait = UIInterfaceOrientationIsPortrait(currOrientation);
    
}

- (void)viewWillAppear:(BOOL)animated {//viewWillAppear:会在ViewController的视图每次即将在屏幕上显示时被调用。
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
    NSLocaleLanguageDirection langDirection;
    langDirection = [NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]];//1
    if(langDirection == NSLocaleLanguageDirectionRightToLeft) {//2
        self.CarInfoLabel.textAlignment = NSTextAlignmentLeft;//3
        self.totalCarsLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    else{
        self.CarInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.totalCarsLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    UIInterfaceOrientation currOrientation = [[UIApplication sharedApplication]statusBarOrientation];//找到当前设备的方向
    BOOL currIsPortrait = UIInterfaceOrientationIsPortrait(currOrientation);//当前设备方向是否为纵向
    if((isShowingPortrait && !currIsPortrait) || (!isShowingPortrait && currIsPortrait)){//控制器的上一个方向是否与当前方向不同
        [self willAnimateRotationToInterfaceOrientation:currOrientation duration:0.0f];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"EditSegue"]){//设置Edit场景，除非这是edit segue
        CarEditViewController *nextCOntroller;
        
        nextCOntroller = segue.destinationViewController;//冲这个segue获得Edit场景的视图控制器。segue拥有源控制器属性和目的控制器属性，也就是当前屏幕上显示的控制器（源控制器）与将要显示的控制器（目的控制器）
//        nextCOntroller.carNumber = displayedCarIndex + 1;//设置car Number属性，机制索引是基于0的
        nextCOntroller.delegate = self;
        Car *currentCar = arrayOfCars[displayedCarIndex];//使用Objective-C的索引而非objectAtIndex方法
        nextCOntroller.currentCar = currentCar;//找到并设置好正确的Car对象
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeDisplayedCar:(NSInteger)newIndex {
    if(newIndex < 0) { //确保新的索引值是有效的索引。如果索引小于0，使值为0
        newIndex = 0;
    } else if(newIndex >= [arrayOfCars count]) {//如果newIndex超出arrayOfCar的范围，就将其设置为最后一个
        newIndex = [arrayOfCars count] - 1;
    }
    if (displayedCarIndex != newIndex) {//仅更新索引值有变化的视图
        displayedCarIndex = newIndex;
        [self displayCurrentCarInfo];
    }
}

- (void)updateLabel:(UILabel*)theLabel
     withBaseString:(NSString*)baseString
              count:(NSInteger)theCount {
    NSString *nexText;
    nexText = [NSString localizedStringWithFormat:@"%@: %ld",baseString,(long)theCount];
    
    theLabel.text = nexText;
}

- (void)displayCurrentCarInfo {
    Car *currentCar;
    currentCar = [arrayOfCars objectAtIndex:displayedCarIndex];
    self.CarInfoLabel.text = currentCar.carInfo;
    [self updateLabel:self.CarNumberLabel withBaseString:NSLocalizedStringWithDefaultValue(@"CarNumberLabel",
                                                                                           nil,
                                                                                           [NSBundle mainBundle],
                                                                                           @"Car Number",
                                                                                           @"Label for the total number of current car")
                count:displayedCarIndex +1];
}

- (Car*)carToEdit {
    return arrayOfCars[displayedCarIndex];
}

- (NSInteger)carNumber {
    return displayedCarIndex + 1;
}

- (void)editedCarUpdated {
    [self displayCurrentCarInfo];
}

- (IBAction)newCar:(id)sender {
    Car *newCar = [[Car alloc] init];
    [arrayOfCars addObject:newCar];
    [self updateLabel:self.totalCarsLabel withBaseString:NSLocalizedStringWithDefaultValue(@"TotalCarsLabel",
                                                                                           nil,
                                                                                           [NSBundle mainBundle],
                                                                                           @"Total Cars",
                                                                                           @"Label for the total number of cars")
                count:[arrayOfCars count]];
}

- (IBAction)previousCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex - 1];
}

- (IBAction)nextCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex + 1];
}

- (IBAction)editingDone:(UIStoryboardSegue*)segue {
    NSLog(@"\neditedCarUpdated called!\n");
    [self displayCurrentCarInfo];
}
- (void)setupLandscapeConstraints {
    NSDictionary *views;//1 创建一个变量绑定字典，用于根据字符串生成约束
//    views = NSDictionaryOfVariableBindings(addCarView,separatorView,viewCarView);
    id topGuide = self.topLayoutGuide;
    id bottomGuide = self.bottomLayoutGuide;
    views = NSDictionaryOfVariableBindings(
                                           topGuide,
                                           bottomGuide,
                                           addCarView,
                                           separatorView,
                                           viewCarView
                                           );
    NSMutableArray *tempRootViewConstraints = [NSMutableArray new];//2 创建一个临时可变数组，存放附属主视图的生成的约束
    NSMutableArray *tempAddViewConstrains=[NSMutableArray new];
    NSMutableArray *tempSeparatorViewConstrains=[NSMutableArray new];
    
    NSArray *generatedConstraints;//3创建一个到所有返回的生成约束属组的可复用引用
    //以下是tempRootViewConstrain的
//    generatedConstraints =//4 生成第上表第一个字符串相关的约束。注意视图字典可以包含都约束字符串所需的约束。这使得为整个方法创建单个视图字典成为可能
//        [NSLayoutConstraint
//         constraintsWithVisualFormat:@"H:|-[addCarView]-2-[separatorView]"
//                            options:0
//                            metrics:nil
//                            views:views];
//    [tempRootViewConstraints addObjectsFromArray:generatedConstraints];//5将生成的约束添加到主视图约束的临时数组中。然后生成其余的主视图约束，将每个新的集合添加到临时数组中
    
    generatedConstraints =
        [NSLayoutConstraint
         constraintsWithVisualFormat:@"V:[topGuide]-[separatorView]-[bottomGuide]"
                            options:0
                            metrics:nil
                            views:views];
    [tempRootViewConstraints addObjectsFromArray:generatedConstraints];

    generatedConstraints =
        [NSLayoutConstraint
         constraintsWithVisualFormat:@"V:[topGuide]-[addCarView]-[bottomGuide]"
                            options:0
                            metrics:nil
         views:views];
    [tempRootViewConstraints addObjectsFromArray:generatedConstraints];
    
    //获得上标题 Current Car Number 和Car info
    generatedConstraints =
    [NSLayoutConstraint
     constraintsWithVisualFormat:@"V:[topGuide]-[viewCarView]-[bottomGuide]"
                            options:0
                            metrics:nil
                            views:views];
    [tempRootViewConstraints addObjectsFromArray:generatedConstraints];
    //获得下面的三个按钮
    generatedConstraints =
    [NSLayoutConstraint
     constraintsWithVisualFormat:@"|-[addCarView]-2-[separatorView]-40-[viewCarView]-|"
                            options:0
                            metrics:nil
                            views:views];
    [tempRootViewConstraints addObjectsFromArray:generatedConstraints];
    //以下是tempAddViewConstrains的
    generatedConstraints=
    [NSLayoutConstraint
     constraintsWithVisualFormat:@"H:[addCarView(132)]"
     options:0
     metrics:nil
     views:views];
    [tempAddViewConstrains addObjectsFromArray:generatedConstraints];
    

    generatedConstraints=
    [NSLayoutConstraint
     constraintsWithVisualFormat:@"H:[separatorView(2)]"
     options:0
     metrics:nil
     views:views];
    [tempSeparatorViewConstrains addObjectsFromArray:generatedConstraints];
    

    //6 将rootViewLandscapeConstraints初始化为生成约束的可变数组的内容
    rootViewLandscapeConstraints = [NSArray arrayWithArray:tempRootViewConstraints];
    //7将addCarViewLandscapeConstraints初始化为包含添加汽车视图的宽度约束的数组
    addCarViewLandscapeConstraints =  [NSArray arrayWithArray:tempAddViewConstrains];
    //8将separatorViewLandscapeConstraints初始化为包含分隔符视图的宽度约束的数组
    separatorViewLandscapeConstraints =[NSArray arrayWithArray:tempSeparatorViewConstrains];
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {//1 调用超类方法之后，弄清楚新的屏幕方向。UIInterfaceOrientationIsPortrait是个系统宏，在纵向屏幕时为true
        [self.view removeConstraints:rootViewLandscapeConstraints];//2这是纵向屏幕，因此移除横向约束，从主视图开始。对还没有附属到视图的约束调用removeConstraints:也是可行的
        [addCarView removeConstraints:addCarViewLandscapeConstraints];
        [separatorView removeConstraints:separatorViewLandscapeConstraints];
        
        [self.view addConstraints:self.rootViewPortraitConstraints];//3添加所有的纵向约束。添加已存在的会被忽略
        [addCarView addConstraints:self.addCarViewPortraitConstraints];
        [separatorView addConstraints:self.separatorViewPortraitConstraints];
    } else {//4横向屏幕
        [self.view removeConstraints:self.rootViewPortraitConstraints];//5移除所有特定于纵向屏幕的约束
        [addCarView removeConstraints:self.addCarViewPortraitConstraints];
        [separatorView removeConstraints:self.separatorViewPortraitConstraints];
        
        [self.view addConstraints:rootViewLandscapeConstraints];//6添加特定于横向屏幕的约束
        [addCarView addConstraints:addCarViewLandscapeConstraints];
        [separatorView addConstraints:separatorViewLandscapeConstraints];
    }
}

- (IBAction)aboutCarValet:(id)sender {
    AboutViewController *nextController;
    
    nextController = [[AboutViewController alloc]initWithNibName:@"AboutViewController"//1
                                                          bundle:[NSBundle mainBundle]];
    
    nextController.title = @"About CarValet";//2
    [self.navigationController pushViewController:nextController animated:YES];
}
@end

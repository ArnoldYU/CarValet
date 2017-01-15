//
//  CarImageViewController.m
//  CarValet
//
//  Created by 黄彬杨 on 2017/1/15.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import "CarImageViewController.h"

@interface CarImageViewController ()

@end

@implementation CarImageViewController{
    NSArray *carImageNames; //1
}

//- (void)setupScrollContent{
//    NSMutableArray *imageViews = [NSMutableArray new];//2
//    
//    CGFloat atX = 0.0;
//    CGFloat maxHeight = 0.0;
//    UIImage *carImage;
//    UIImageView *atImageView;
//    
//    for (NSString *atCarImageName in carImageNames) {//3
//        carImage = [UIImage imageNamed:atCarImageName];
//        atImageView = [[UIImageView alloc] initWithImage:carImage];
//        
//        atImageView.frame = CGRectMake(atX, 0.0, atImageView.bounds.size.width, atImageView.bounds.size.height);//4
//        
//        [imageViews addObject:atImageView];
//        
//        atX += atImageView.bounds.size.width;//5
//        if (atImageView.bounds.size.height > maxHeight) {//6
//            maxHeight = atImageView.bounds.size.height;
//        }
//    }
//    
//    UIView *carImageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, atX, maxHeight)];//7
//    
//    for (UIImageView *atImageView in imageViews) {//8
//        [carImageContainerView addSubview:atImageView];
//    }
//    
//    [self.scrollView addSubview:carImageContainerView];//9
//    self.scrollView.contentSize = carImageContainerView.bounds.size;
//}
- (void)setupScrollContent{
    CGFloat scrollWidth = self.view.bounds.size.width;//1
    CGFloat totalWidth = scrollWidth * [carImageNames count];//2
    
    UIView *carImageContainerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, totalWidth, self.scrollView.frame.size.height)];
    
    CGFloat atX = 0.0;
    CGFloat maxHeight = 0.0;
    UIImage *carImage;
    
    for (NSString *atCarImageName in carImageNames) {
        carImage = [UIImage imageNamed:atCarImageName];
        CGFloat scale = scrollWidth / carImage.size.width;//3
        
        UIImageView *atImageView = [[UIImageView alloc]initWithImage:carImage];
        
        CGFloat newHeight = atImageView.bounds.size.height;//4
        
        atImageView.frame = CGRectMake(atX, 0.0, scrollWidth, newHeight);
        
        if (newHeight > maxHeight) {
            maxHeight = newHeight;
        }
        
        atX += scrollWidth;
        
        [carImageContainerView addSubview:atImageView];
    }
    CGRect newFrame = carImageContainerView.frame;
    newFrame.size.height = maxHeight;
    carImageContainerView.frame = newFrame;
    
    [self.scrollView addSubview:carImageContainerView];
    self.scrollView.contentSize = carImageContainerView.bounds.size;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    carImageNames = @[ @"Car/1.jpg",@"Car/2.jpg",@"Car/3.jpeg",@"Car/4.jpg",@"Car/5.jpg"];//10
    [self setupScrollContent];
    // Do any additional setup after loading the view.
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

@end

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
    
    UIView *carImageContainerView;
}

- (void)setupScrollContent{
    
    if (carImageContainerView != nil) {
        [carImageContainerView removeFromSuperview];
    }
    
    
    CGFloat scrollWidth = self.view.bounds.size.width;//1
    CGFloat totalWidth = scrollWidth * [carImageNames count];//2
    
    carImageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, totalWidth, self.scrollView.frame.size.height)];
    
    
//    UIView *carImageContainerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, totalWidth, self.scrollView.frame.size.height)];
    
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

- (void)updateCarNumberLabel {
    NSInteger carIndex = [self carIndexForPoint:self.scrollView.contentOffset];
    
    NSString *newText = [NSString stringWithFormat:@"Car Number: %ld",carIndex+1];
    
    self.carNumberLabel.text = newText;
}

- (NSInteger)carIndexForPoint:(CGPoint)thePoint {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    
    pageWidth *= self.scrollView.zoomScale; //1
    
    return (NSInteger)(thePoint.x/pageWidth);//2
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateCarNumberLabel];//3
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = YES;
    self.resetZoomButton.enabled = NO;
    
    carImageNames = @[ @"Car/1.jpg",@"Car/2.jpg",@"Car/3.jpeg",@"Car/4.jpg",@"Car/5.jpg"];//10
    [self setupScrollContent];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    [self updateCarNumberLabel];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self setupScrollContent];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return carImageContainerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    self.resetZoomButton.enabled = scale != 1.0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetZoom:(id)sender {
    [self.scrollView setZoomScale:1.0 animated:YES];
}
@end

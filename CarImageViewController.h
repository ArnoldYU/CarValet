//
//  CarImageViewController.h
//  CarValet
//
//  Created by 黄彬杨 on 2017/1/15.
//  Copyright © 2017年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarImageViewController : UIViewController
<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetZoomButton;

- (IBAction)resetZoom:(id)sender;

@end

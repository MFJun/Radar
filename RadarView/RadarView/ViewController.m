//
//  ViewController.m
//  RadarView
//
//  Created by MengFanJun on 2016/11/9.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+RCColor.h"
#import "RadarView.h"

//视图宽度
#define viewWidth [UIScreen mainScreen].bounds.size.width
//视图高度
#define viewHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) RadarView *radarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatSubViews];

}

- (void)creatSubViews
{
    //添加背景颜色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"1d2441" alpha:1].CGColor,(__bridge id)[UIColor colorWithHexString:@"235d73" alpha:1].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view.layer addSublayer:gradientLayer];
    
    self.radarView = [[RadarView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    self.radarView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.radarView.radius = 60;
    self.radarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.radarView];
    [self.radarView startAction];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

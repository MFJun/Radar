//
//  RadarIndicatorView.m
//  RadarView
//
//  Created by MengFanJun on 2016/11/10.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "RadarIndicatorView.h"
#import "UIColor+RCColor.h"

#define RADAR_ROTATE_SPEED 120.0f//动画速度

@interface RadarIndicatorView ()

@property (nonatomic, strong) CAShapeLayer *layer1;
@property (nonatomic, strong) CAShapeLayer *layer2;
@property (nonatomic, strong) CAShapeLayer *layer3;
@property (nonatomic, strong) CAShapeLayer *layer4;

@end

@implementation RadarIndicatorView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 半径
    CGFloat radius = 5;
    // 起始角
    CGFloat startAngle = 0;
    // 结束角
    CGFloat endAngle = 2 * M_PI;
    
    // 画四个圆点
    /*
     center: 弧线中心点的坐标
     radius: 弧线所在圆的半径
     startAngle: 弧线开始的角度值
     endAngle: 弧线结束的角度值
     clockwise: 是否顺时针画弧线
     */
    CGPoint center1 = CGPointMake(rect.size.width / 2 - 12, rect.size.height / 2 - self.radius + 1);
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:center1 radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _layer1 = [[CAShapeLayer alloc] init];
    _layer1.path = path1.CGPath;
    _layer1.fillColor = [UIColor colorWithHexString:@"fda231" alpha:1].CGColor;
    [self.layer addSublayer:_layer1];
    
    CGPoint center2 = CGPointMake(rect.size.width / 2 - 4, rect.size.height / 2 - self.radius);
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:center2 radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _layer2 = [[CAShapeLayer alloc] init];
    _layer2.path = path2.CGPath;
    _layer2.fillColor = [UIColor colorWithHexString:@"fda231" alpha:0.8].CGColor;
    [self.layer addSublayer:_layer2];
    
    CGPoint center3 = CGPointMake(rect.size.width / 2 + 4, rect.size.height / 2 - self.radius);
    UIBezierPath * path3 = [UIBezierPath bezierPathWithArcCenter:center3 radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _layer3 = [[CAShapeLayer alloc] init];
    _layer3.path = path3.CGPath;
    _layer3.fillColor = [UIColor colorWithHexString:@"fda231" alpha:0.5].CGColor;
    [self.layer addSublayer:_layer3];

    CGPoint center4 = CGPointMake(rect.size.width / 2 + 12, rect.size.height / 2 - self.radius + 1);
    UIBezierPath * path4 = [UIBezierPath bezierPathWithArcCenter:center4 radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _layer4 = [[CAShapeLayer alloc] init];
    _layer4.path = path4.CGPath;
    _layer4.fillColor = [UIColor colorWithHexString:@"fda231" alpha:0.3].CGColor;
    [self.layer addSublayer:_layer4];
    
}

//控制圆点隐藏、出现动画
- (void)scan{
    [self stop];
    
    //透明度动画
    //控制keyTimes及对应的values，控制圆点出现、隐藏顺序
    CAKeyframeAnimation * opacityAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation1.values = @[@0, @0, @0, @0, @0, @1, @1, @1, @1, @1, @1];
    opacityAnimation1.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    opacityAnimation1.duration = 360.f/RADAR_ROTATE_SPEED;
    opacityAnimation1.repeatCount = INT_MAX;
    opacityAnimation1.removedOnCompletion = NO;
    [_layer2 addAnimation:opacityAnimation1 forKey:@"hiden"];
    
    CAKeyframeAnimation * opacityAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation2.values = @[@0, @0, @0, @0, @0, @0, @1, @1, @1, @1, @0];
    opacityAnimation2.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.42, @0.6, @0.7, @0.8, @0.96, @0.98];
    opacityAnimation2.duration = 360.f/RADAR_ROTATE_SPEED;
    opacityAnimation2.repeatCount = INT_MAX;
    opacityAnimation2.removedOnCompletion = NO;
    [_layer3 addAnimation:opacityAnimation2 forKey:@"hiden"];
    
    CAKeyframeAnimation * opacityAnimation3 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation3.values = @[@0, @0, @0, @0, @0, @0, @0, @1, @1, @0, @0];
    opacityAnimation3.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.42, @0.44, @0.7, @0.8, @0.96, @1];
    opacityAnimation3.duration = 360.f/RADAR_ROTATE_SPEED;
    opacityAnimation3.repeatCount = INT_MAX;
    opacityAnimation3.removedOnCompletion = NO;
    [_layer4 addAnimation:opacityAnimation3 forKey:@"hiden"];

}

- (void)stop
{
    [_layer2 removeAnimationForKey:@"hiden"];
    [_layer3 removeAnimationForKey:@"hiden"];
    [_layer4 removeAnimationForKey:@"hiden"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

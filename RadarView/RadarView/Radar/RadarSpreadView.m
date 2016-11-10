//
//  RadarSpreadView.m
//  RadarView
//
//  Created by MengFanJun on 2016/11/10.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//


#import "RadarSpreadView.h"
#import "UIColor+RCColor.h"

@implementation RadarSpreadView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 半径
    CGFloat radius = self.radius;
    // 起始角
    CGFloat startAngle = 0;
    // 圆心
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    // 结束角
    CGFloat endAngle = 2 * M_PI;
    
    /*
     center: 弧线中心点的坐标
     radius: 弧线所在圆的半径
     startAngle: 弧线开始的角度值
     endAngle: 弧线结束的角度值
     clockwise: 是否顺时针画弧线
     */
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor colorWithHexString:@"fda231" alpha:0.3].CGColor;
    
    [self.layer addSublayer:layer];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

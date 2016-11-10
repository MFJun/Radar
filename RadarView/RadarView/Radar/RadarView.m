//
//  RadarView.m
//  RadarView
//
//  Created by MengFanJun on 2016/11/10.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import "RadarView.h"
#import "RadarSpreadView.h"
#import "RadarIndicatorView.h"
#import "UIColor+RCColor.h"

#define RADAR_ROTATE_SPEED 120.0f//动画速度
#define RADIUS 15//中心圆半径

@implementation RadarView

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if (!self.indicatorView) {
        RadarIndicatorView *indicatorView = [[RadarIndicatorView alloc] initWithFrame:self.bounds];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    if (!self.radarSpreadView) {
        RadarSpreadView *radarSpreadView = [[RadarSpreadView alloc] initWithFrame:self.bounds];
        [self addSubview:radarSpreadView];
        _radarSpreadView = radarSpreadView;
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    // 半径
    CGFloat radius = RADIUS;
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
    layer.fillColor = [UIColor colorWithHexString:@"fda231" alpha:1].CGColor;
    
    [self.layer addSublayer:layer];
    
    if (self.indicatorView) {
        self.indicatorView.frame = self.bounds;
        self.indicatorView.backgroundColor = [UIColor clearColor];
        self.indicatorView.radius = self.radius;
    }
    if (self.radarSpreadView) {
        self.radarSpreadView.frame = self.bounds;
        self.radarSpreadView.backgroundColor = [UIColor clearColor];
        self.radarSpreadView.radius = RADIUS;
    }
    
}

#pragma mark - Actions

- (void)startAction {
    [self stopAction];
    
    //指针旋转动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //是否顺时针
    BOOL indicatorClockwise = NO;
    rotationAnimation.toValue = [NSNumber numberWithFloat: (indicatorClockwise?1:-1) * M_PI * 2.0 ];
    rotationAnimation.duration = 360.f/RADAR_ROTATE_SPEED;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = INT_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [_indicatorView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.fillMode = kCAFillModeBackwards;
    animationGroup.duration = 360.f/RADAR_ROTATE_SPEED;
    animationGroup.repeatCount = INT_MAX;
    animationGroup.removedOnCompletion = NO;
    //扩散动画
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1, @1.4, @1.8, @2.2, @2.6, @2.8, @3.0, @3.0, @3.0, @3.0, @3.0];
    scaleAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    //透明度动画
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1.0, @1.0, @0.9, @0.8, @0.6, @0.4, @0.2, @0, @0, @0, @0];
    opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    [_radarSpreadView.layer addAnimation:animationGroup forKey:@"plulsing"];
    
}

- (void)stopAction {
    
    [_indicatorView.layer removeAnimationForKey:@"rotationAnimation"];
    [_radarSpreadView.layer removeAnimationForKey:@"plulsing"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

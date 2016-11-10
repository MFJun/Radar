//
//  RadarView.h
//  RadarView
//
//  Created by MengFanJun on 2016/11/10.
//  Copyright © 2016年 MengFanJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadarSpreadView;
@class RadarIndicatorView;

@interface RadarView : UIView

@property (nonatomic, assign) CGFloat radius;//雷达扫描半径

@property (nonatomic, strong) RadarIndicatorView *indicatorView;//指针
@property (nonatomic, strong) RadarSpreadView *radarSpreadView;//扩散视图

- (void)startAction;//扫描
- (void)stopAction;//停止

@end

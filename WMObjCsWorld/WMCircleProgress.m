//
//  WMCircleProgress.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/19.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMCircleProgress.h"

float const kProgressLineWidthDefault = 7.0;

@interface WMCircleProgress()

@property (strong, nonatomic) UIBezierPath* path;
@property (strong, nonatomic) CAShapeLayer* background;
@property (strong, nonatomic) CAShapeLayer* progress;
@property (assign, nonatomic) CGFloat current;
@property (strong, nonatomic) UIColor* backgroundColor;
@property (strong, nonatomic) UIColor* progressColor;

@end

@implementation WMCircleProgress

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaulViews];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupDefaulViews];
}

- (void)setupCircleProgressBackgroundColor:(UIColor*)backgroundColor progressColor:(UIColor*)progressColor {

    _background.strokeColor = backgroundColor.CGColor;
    _progress.strokeColor = progressColor.CGColor;
}


- (void)setupCircleProgressWidth:(CGFloat)progressWidth backgroundColor:(UIColor*)backgroundColor progressColor:(UIColor*)progressColor {
    _background.lineWidth = progressWidth;
    _progress.lineWidth = progressWidth;
    
    _background.strokeColor = backgroundColor.CGColor;
    _progress.strokeColor = progressColor.CGColor;
    
    [_path removeAllPoints];
    CGFloat radius = CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds) ? floor(CGRectGetWidth(self.bounds) / 2.00 - progressWidth ): floor(CGRectGetHeight(self.bounds) / 2.00 - progressWidth);
    [_path addArcWithCenter:CGPointMake(floor(CGRectGetWidth(self.bounds) / 2), floor(CGRectGetHeight(self.bounds) / 2)) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
}

- (void)setupDefaulViews {
    _current = 0;
    _backgroundColor = [UIColor lightGrayColor];
    _progressColor = [UIColor redColor];
    _path = [[UIBezierPath alloc] init];
    CGFloat radius = CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds) ? floor(CGRectGetMidX(self.bounds) - kProgressLineWidthDefault ): floor(CGRectGetMidY(self.bounds)- kProgressLineWidthDefault);
    [_path addArcWithCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:(int)radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];

    
    _background = [CAShapeLayer layer];
    _background.path = _path.CGPath;
    _background.fillColor = [UIColor clearColor].CGColor;
    _background.strokeColor = _backgroundColor.CGColor;
    _background.lineCap = kCALineCapRound;
    _background.strokeStart = 0;
    _background.strokeEnd = 1;
    _background.lineWidth = kProgressLineWidthDefault;
    [self.layer addSublayer:_background];
    
    _progress = [CAShapeLayer layer];
    _progress.path = _path.CGPath;
    _progress.fillColor = [UIColor clearColor].CGColor;
    _progress.strokeColor = _progressColor.CGColor;
    _progress.lineCap = kCALineCapRound;
    _progress.strokeStart = 0;
    _progress.strokeEnd = _current;
    _progress.lineWidth = kProgressLineWidthDefault;
    [self.layer addSublayer:_progress];
}

- (void)setCurrent:(CGFloat)current {
    if (current > 1) {
        current = 1;
    } else if (current < 0) {
        current = 0;
    }
    
    _current = current;
    _progress.strokeEnd = current;
}

@end

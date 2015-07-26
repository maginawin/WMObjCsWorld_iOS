//
//  WMBasicAnimationVC.m
//  WMObjCsWorld
//
//  Created by wangwendong on 15/7/26.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBasicAnimationVC.h"

@interface WMBasicAnimationVC ()
@property (weak, nonatomic) IBOutlet UIView *mBasicView;

@end

@implementation WMBasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)startScaleClick:(id)sender {
    [self configureScaleAnimation];
    
    NSLog(@"position x : %f, y : %f", _mBasicView.layer.position.x, _mBasicView.layer.position.y);
}

- (IBAction)stopScaleClick:(id)sender {
    [_mBasicView.layer removeAllAnimations];
}

- (IBAction)startKeyframeClick:(id)sender {
    [self configureKeyframeAnimation];
}

#pragma mark - Configure animations

- (void)configureScaleAnimation {
    CALayer *layer = _mBasicView.layer;
    
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnim.fromValue = @1.0;
    basicAnim.toValue = @1.2;
    basicAnim.duration = 0.7f;
    basicAnim.autoreverses = YES;
    basicAnim.repeatCount = MAXFLOAT;
    
    [layer addAnimation:basicAnim forKey:@"scaleBasicView"];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @.5f;
    opacityAnim.toValue = @1.f;
    opacityAnim.duration = 0.7f;
    opacityAnim.autoreverses = YES;
    opacityAnim.repeatCount = MAXFLOAT;
    
    [layer addAnimation:opacityAnim forKey:@"opacityAnim"];
}

- (void)configureKeyframeAnimation {
    CALayer *layer = _mBasicView.layer;
    
    CAKeyframeAnimation *keyframeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(160, 380)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(80, 380)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(80, 300)];
    keyframeAnim.values = @[[NSValue valueWithCGPoint:layer.position], value1, value2, value3, [NSValue valueWithCGPoint:layer.position]];
    
    CAMediaTimingFunction *mtf0 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *mtf1 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAMediaTimingFunction *mtf2 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *mtf3 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    keyframeAnim.timingFunctions = @[mtf0, mtf0, mtf1, mtf2, mtf3];
    
    keyframeAnim.keyTimes = @[@0, @0.2, @0.3, @0.4, @1]; // 表示所在的时间点, 比如 0.1 表示在 0.6 秒, 0.4 表示在 2.4 秒, 1 表示到 6 秒
    
    keyframeAnim.autoreverses = NO;
    keyframeAnim.duration = 6.f;
    keyframeAnim.repeatCount = MAXFLOAT;
    
    [layer addAnimation:keyframeAnim forKey:@"keyframeAnim"];
}

@end

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

- (IBAction)stopScaleClick:(id)sender {
    [_mBasicView.layer removeAllAnimations];
}

@end

//
//  WMCircleProgress.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/19.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMCircleProgress : UIView

/**
 * @brief 更改进度条的背景条色和前景条色
 * @param backgroundColor : 背景进度条色
 * @param progressColor : 前景进度条色
 */
- (void)setupCircleProgressBackgroundColor:(UIColor*)backgroundColor progressColor:(UIColor*)progressColor;

/**
 * @brief 进度条可能突破天际, 暂时不建议调用, 若要真改 lineWidth 去 implementation 中改 progress line width default const
 */
- (void)setupCircleProgressWidth:(CGFloat)progressWidth backgroundColor:(UIColor*)backgroundColor progressColor:(UIColor*)progressColor;

/**
 * @brief 更改进度条的值, 0 ~ 1 
 * @param curren : 进度条的值
 */
- (void)setCurrent:(CGFloat)current;

@end

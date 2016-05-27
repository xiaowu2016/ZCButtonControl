//
//  ZCBaseView.h
//  ZCButtonControl
//
//  Created by zhangchao on 16/5/26.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCBaseView : UIView
/**
 *  通过传入的标题名，页面，和frame来创建一个新的组合页面
 *
 *  @param title 标题名
 *  @param views 页面
 *  @param frame frame
 *
 *  @return 组合页面
 */
- (instancetype)initWithTitles:(NSArray *)titles AndViews:(NSArray *)views AtFrame:(CGRect)frame;
/**
 *  设置控件按钮部位的颜色
 *
 *  @param color 颜色
 */
- (void)setButtonViewBackgroundColor:(UIColor *)color;
@end

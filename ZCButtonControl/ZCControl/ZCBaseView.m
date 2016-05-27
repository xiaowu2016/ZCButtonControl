//
//  ZCBaseView.m
//  ZCButtonControl
//
//  Created by zhangchao on 16/5/26.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ZCBaseView.h"
#import "ZCBaseControl.h"
#import "Masonry.h"

@interface ZCBaseView ()
@property (nonatomic,strong) ZCBaseControl *baseControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *viewArray;
@end

@implementation ZCBaseView
- (instancetype)initWithTitles:(NSArray *)titles AndViews:(NSArray *)views AtFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleArray = titles;
        self.viewArray = views;
        [self addSubview:self.baseControl];
        [self addSubview:self.scrollView];
        [self setFrames];
    }
    return self;
}

- (void)setFrames
{
    [self.baseControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
        make.top.equalTo(self).offset(20);
        make.height.mas_equalTo(35);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.baseControl.mas_bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(0);
    }];
   
    for(NSUInteger i = 0; i < self.viewArray.count ; i++)
    {
        if(i == 0)
        {
            [self.viewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(self.scrollView);
                make.left.top.equalTo(self.scrollView);
            }];
        }
        else
        {
            UIView *tempView = self.viewArray[i - 1];
            [self.viewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(self.scrollView);
                make.top.equalTo(self.scrollView);
                make.left.equalTo(tempView.mas_right);
            }];
        }
    }
}

- (void)setButtonViewBackgroundColor:(UIColor *)color;
{
    self.baseControl.backgroundColor = color;
}

- (void)clickButtonAction
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * self.baseControl.selectIndex, 0) animated:YES];
}

#pragma mark setter ,getter
- (NSArray *)titleArray
{
    if(_titleArray == nil)
    {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSArray *)viewArray
{
    if(_viewArray == nil)
    {
        _viewArray = [NSArray array];
    }
    return _viewArray;
}

- (ZCBaseControl *)baseControl
{
    if(_baseControl == nil)
    {
        _baseControl = [[ZCBaseControl alloc] initWithTitles:self.titleArray];
        [_baseControl addTarget:self action:@selector(clickButtonAction) forControlEvents:UIControlEventValueChanged];
        _baseControl.selectIndex = 0;
    }
    return _baseControl;
}

- (UIScrollView *)scrollView
{
    if(_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = NO;
        for(UIView *view in self.viewArray)
        {
            [_scrollView addSubview:view];
        }
    }
    return _scrollView;
}
@end

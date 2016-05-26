//
//  ViewController.m
//  ZCButtonControl
//
//  Created by zhangchao on 16/5/23.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "ZCBaseControl.h"
#import "TableView.h"
#import "Masonry.h"
#import "ZCControl/ZCBaseView.h"

@interface ViewController ()<UIScrollViewDelegate,viewDelegate>
@property (nonatomic,strong) ZCBaseControl *seg;
@property (nonatomic,strong) UIScrollView *contentSC;
@property (nonatomic,strong) TableView *historyTB;
@property (nonatomic,strong) TableView *nowTB;
@property (nonatomic,strong) TableView *futureTB;
@property (nonatomic,strong) UIView *historyView;
@property (nonatomic,strong) UIView *nowView;
@property (nonatomic,strong) UIView *futureView;
@property (nonatomic,strong) ZCBaseView *baseView;
@end


@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.seg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(4);
        make.right.equalTo(self.view).offset(-4);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(35);
    }];
    
    [self.contentSC mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.seg.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(self.contentSC);
        make.left.top.equalTo(self.contentSC);
    }];
    
    [self.nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(self.contentSC);
        make.top.equalTo(self.contentSC);
        make.left.equalTo(self.historyView.mas_right);
    }];
    
    
    [self.futureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(self.contentSC);
        make.top.equalTo(self.contentSC);
        make.left.equalTo(self.nowView.mas_right);
    }];
    
    [self.historyTB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.historyView);
    }];
    
    [self.nowTB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.nowView);
    }];
    
    [self.futureTB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.futureView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.seg];
//    [self.view addSubview:self.contentSC];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view = self.baseView;
}



- (void)clickSegmentAction
{
    [self.contentSC setContentOffset:CGPointMake(self.contentSC.frame.size.width * self.seg.selectIndex, 0) animated:YES];
}

// 实现代理方法
- (void)ShouldEnterDetailViewControllerWithItem:(id)item{
    
    NSLog(@"%@",item);
    
}


- (ZCBaseControl *)seg
{
    if(_seg == nil)
    {
        _seg = [[ZCBaseControl alloc] initWithTitles:@[@"历史", @"现在",@"未来"]];
        [_seg addTarget:self action:@selector(clickSegmentAction) forControlEvents:UIControlEventValueChanged];
        _seg.selectIndex = 0;
    }
    return _seg;
}


- (UIScrollView *)contentSC
{
    if(_contentSC == nil)
    {
        _contentSC = [[UIScrollView alloc] init];
        _contentSC.scrollEnabled = NO;
        _contentSC.delegate = self;
        [_contentSC addSubview:self.historyView];
        [_contentSC addSubview:self.nowView];
        [_contentSC addSubview:self.futureView];
    }
    return _contentSC;
}


- (UIView *)historyView
{
    if(_historyView == nil)
    {
        _historyView = [[UIView alloc] init];
        [_historyView addSubview:self.historyTB];
    }
    return _historyView;
}


- (TableView *)historyTB
{
    if(_historyTB == nil)
    {
        _historyTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historyTB.types = ShoppingTypeHistory;
        _historyTB.myDelegate = self;
    }
    return _historyTB;
}

- (UIView *)nowView
{
    if(_nowView == nil)
    {
        _nowView = [[UIView alloc] init];
        [_nowView addSubview:self.nowTB];
    }
    return _nowView;
}

- (TableView *)nowTB
{
    if(_nowTB == nil)
    {
        _nowTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _nowTB.types = ShoppingTypeQuoting;
        _nowTB.myDelegate = self;
    }
    return _nowTB;
}

- (UIView *)futureView
{
    if(_futureView == nil)
    {
        _futureView = [[UIView alloc] init];
        [_futureView addSubview:self.futureTB];
    }
    return _futureView;
}

- (TableView *)futureTB
{
    if(_futureTB == nil)
    {
        _futureTB = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _futureTB.types = ShoppingTypeFuture;
        _futureTB.myDelegate = self;
    }
    return _futureTB;
}


- (ZCBaseView *)baseView
{
    if(_baseView == nil)
    {
        _baseView = [[ZCBaseView alloc] initWithTitles:@[@"历史", @"现在",@"未来"] AndViews:@[self.historyTB,self.nowTB,self.futureTB] AtFrame:self.view.bounds];
    }
    return _baseView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

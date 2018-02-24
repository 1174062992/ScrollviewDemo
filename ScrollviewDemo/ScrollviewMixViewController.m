//
//  ScrollviewMixViewController.m
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ScrollviewMixViewController.h"
#import "HeaderScrollview.h"
#import "BodyScrollview.h"
#import "BodyDataModel.h"
@interface ScrollviewMixViewController ()<HeaderScrollviewDelegate, BodyScrollviewDelegate>
{
    HeaderScrollview *_headerScrollView;
    BodyScrollview   *_bodyScrollview;
}
@end

@implementation ScrollviewMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"混合滚动";
    
    // Do any additional setup after loading the view.
    [self setUpHeaderView];
    [self setUpBodyView];
}

//设置头滚动视图
- (void)setUpHeaderView{
    _headerScrollView  = [[HeaderScrollview alloc] initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,44)];
    //设置代理,获取点击事件
    _headerScrollView.delegate = self;
    _headerScrollView.dataSource = [NSMutableArray arrayWithArray:[self setUpDataSource]];
    [self.view addSubview:_headerScrollView];
}

//设置 body 滚动视图
- (void)setUpBodyView{
    
    _bodyScrollview = [[BodyScrollview alloc] initWithFrame:CGRectMake(0, 108, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-104)];
    _bodyScrollview.delegate = self;
    _bodyScrollview.pages = [self setUpDataSource];
    _bodyScrollview.pageDataSource = [self setUpBodyDataSource];
    [self.view addSubview:_bodyScrollview];
}

- (NSMutableArray *)setUpBodyDataSource{
    
    NSMutableArray *buffer1 = [NSMutableArray new];
    NSMutableArray *buffer2 =[NSMutableArray new];
    for (int j = 0; j<[self setUpDataSource].count; j++) {
        for (int i = 0; i <5; i++) {
            
            BodyDataModel *model = [BodyDataModel new];
            model.firstContent = [NSString stringWithFormat:@"曹记-%d",i];
            model.secondContent = @"18/09/09 12:33";
            model.thirdContent = @"1000.00";
            [buffer2 addObject:model];
        }
        
        [buffer1 addObject:buffer2];
    }
   
    return buffer1;
    
}

//设置数据源
- (NSArray *)setUpDataSource{
    //return @[@"销售订单(0)",@"退货订单(0)",@"销售单(0)",@"退货单(0)",@"退货单(1)",@"退货单(2)"];
    return @[@"销售订单(0)",@"退货订单(0)"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- HeaderScrollviewDelegate
- (void)header_disSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_bodyScrollview scrollToDesPageWithIndexPath:indexPath];
}

#pragma mark -- BodyScrollviewDelegate
- (void)body_didScrollAtPage:(NSInteger)page{
    
    [_headerScrollView scrollCollectionItemToDesWithDesIndex:page];
}

- (void)body_didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Tip" message:[NSString stringWithFormat:@"点击了第 %ld 页  第 %ld 行",indexPath.section, indexPath.row] preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertViewStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end

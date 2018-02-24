//
//  BodyCollectionViewCell.m
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "BodyCollectionViewCell.h"
#import "BodyTableViewCell.h"
#import "BodyDataModel.h"
@implementation BodyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.tableview registerNib:[UINib nibWithNibName:@"BodyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BodyTableViewCellID"];
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
    _dataSource = dataSource;
    [self.tableview reloadData];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1: self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BodyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BodyTableViewCellID" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.firstLB.text = @"单据尾号";
        cell.secondLB.text = @"操作时间";
        cell.threeLB.text = @"金额";
    }else{
        BodyDataModel *model = [self.dataSource objectAtIndex:indexPath.row];
        cell.firstLB.text = model.firstContent;
        cell.secondLB.text = model.secondContent;
        cell.threeLB.text = model.thirdContent;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section == 0 ? 0.01:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(bodyCollection_didSelectRowWith:)]) {
            [self.delegate bodyCollection_didSelectRowWith:indexPath];
        }
 
    }
}

@end

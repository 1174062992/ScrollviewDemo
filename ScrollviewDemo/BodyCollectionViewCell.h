//
//  BodyCollectionViewCell.h
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BodyCollectionViewCellDelegate<NSObject>

- (void)bodyCollection_didSelectRowWith:(NSIndexPath *)indexPath;

@end


@interface BodyCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>

/**<#添加注释#>**/
@property (weak, nonatomic) IBOutlet UITableView *tableview;
/**<#添加注释#>**/
@property (nonatomic, strong) NSMutableArray *dataSource;
/**<#添加注释#>**/
@property (nonatomic, assign) id<BodyCollectionViewCellDelegate> delegate;

@end

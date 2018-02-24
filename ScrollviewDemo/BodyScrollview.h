//
//  BodyScrollview.h
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BodyScrollviewDelegate<NSObject>

@required
- (void)body_didScrollAtPage:(NSInteger)page;
- (void)body_didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface BodyScrollview : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/**分页数据源**/
@property (nonatomic, strong)  NSArray *pages;
/**每一页的数据源**/
@property (nonatomic, strong)  NSMutableArray *pageDataSource;
/**<#添加注释#>**/
@property (nonatomic, assign) id<BodyScrollviewDelegate> delegate;

- (void)scrollToDesPageWithIndexPath:(NSIndexPath *)indexPath;

@end

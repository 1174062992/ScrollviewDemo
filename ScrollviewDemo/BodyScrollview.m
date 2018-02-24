//
//  BodyScrollview.m
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "BodyScrollview.h"
#import "BodyCollectionViewCell.h"
@interface BodyScrollview()<BodyCollectionViewCellDelegate>
{
    UICollectionView *_collec;
    NSInteger        _currentPage;
}
@end


@implementation BodyScrollview

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collec = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    _collec = collec;
    _collec.showsHorizontalScrollIndicator = YES;
    _collec.delegate = self;
    _collec.dataSource = self;
    _collec.bounces = NO;
    _collec.alpha = 0.95;
    _collec.pagingEnabled = YES;
    
    //注册自定义的UICollectionViewCell
    [_collec registerNib:[UINib nibWithNibName:@"BodyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"BodyCollectionViewCellID"];
    
    [self addSubview:_collec];
}

- (void)scrollToDesPageWithIndexPath:(NSIndexPath *)indexPath{
    
    _currentPage = indexPath.row;
    [_collec scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}


#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.pages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BodyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BodyCollectionViewCellID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataSource = [self.pageDataSource objectAtIndex:indexPath.row];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//结束拖拽时,计算当前位于第几页
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = (int)(scrollView.contentOffset.x) / (int)(self.frame.size.width);
    _currentPage = currentPage;
    if (self.delegate && [self.delegate respondsToSelector:@selector(body_didScrollAtPage:)]) {
        [self.delegate body_didScrollAtPage:currentPage];
    }
    
}


#pragma mark -- BodyCollectionViewCellDelegate
- (void)bodyCollection_didSelectRowWith:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(body_didSelectRowAtIndexPath:)]) {
        NSIndexPath *currIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:_currentPage];
        [self.delegate body_didSelectRowAtIndexPath:currIndexPath];
    }
    
}


@end

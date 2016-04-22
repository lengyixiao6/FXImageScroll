//
//  FXImageCollectionView.m
//  FXImageScroll
//
//  Created by Benniu15 on 16/4/21.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "FXImageCollectionView.h"
#import "FXImageWheelCell.h"

//demo未完善完成。。。
@interface FXImageCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    NSMutableArray   * _dataArray;
    UICollectionView * _collectionView;
    UIPageControl    * _pageControl;
}

@end

#define Width  self.frame.size.width
#define Height self.frame.size.height

@implementation FXImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArray = [NSMutableArray arrayWithArray:dataArray];
        [self setupView:frame];
    }
    return self;
}
- (void)setupView:(CGRect)rect{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(rect.size.width, rect.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(Width, 0);
    [self addSubview:_collectionView];
    [_collectionView registerClass:[FXImageWheelCell class] forCellWithReuseIdentifier:@"cell"];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _collectionView.frame.size.height-30, _collectionView.frame.size.width, 30)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FXImageWheelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger p = scrollView.contentOffset.x/Width;
    
    if (p == 2) {
        
        [self changArray:YES];
    }
    else if (p == 0) {
        
        [self changArray:NO];
    }
    scrollView.contentOffset = CGPointMake(Width, 0);
}
//***改变数组元素的顺序，刷新表格***
- (void)changArray:(BOOL)isOrder{
    
    NSMutableArray * array = [NSMutableArray new];
    if (isOrder) {
        
        for (int i = 0; i < _dataArray.count; i ++) {
            
            if (i > 0) {
                
                [array addObject:_dataArray[i]];
            }
        }
        [array addObject:_dataArray[0]];
    }
    else{
        
        for (int i = 0; i < _dataArray.count-1; i ++) {
            
            [array addObject:_dataArray[i]];
        }
        [array insertObject:_dataArray.lastObject atIndex:0];
        
    }
    _dataArray = array;
    [_collectionView reloadData];
}

@end



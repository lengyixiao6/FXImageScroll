//
//  FXImageWheel.m
//  BBB
//
//  Created by Benniu15 on 16/4/21.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "FXImageWheel.h"

@interface FXImageWheel () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView   *scrollView;
@property (nonatomic, strong) UIPageControl  *pageControl;
@property (nonatomic, strong) UIImageView    *leftImgV;
@property (nonatomic, strong) UIImageView    *midImgV;
@property (nonatomic, strong) UIImageView    *rightImgV;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSTimer        *timer;
@property (nonatomic, assign) NSInteger      index;
@property (nonatomic, assign) BOOL           isDragging;

@end

@implementation FXImageWheel

#define Width  self.frame.size.width
#define Height self.frame.size.height
#define Times  2

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArr = [NSMutableArray arrayWithArray:dataArray];
        //若数组元素不足3个，补足3个
        if (_dataArr.count == 1) {
            
            [_dataArr addObject:_dataArr[0]];
            [_dataArr addObject:_dataArr[0]];
        }else if (_dataArr.count == 2) {
            
            [_dataArr addObject:_dataArr[0]];
            [_dataArr addObject:_dataArr[1]];
        }
        
        [self setupView];
    }
    return self;
}
- (void)setupView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(Width*3, Height);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(Width, 0)];
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.leftImgV];
    [self.scrollView addSubview:self.midImgV];
    [self.scrollView addSubview:self.rightImgV];
    [self setupImageView];
    
    //添加页码
    [self addSubview:self.pageControl];
    
    //开启定时器
    [self creatTimer];
}
- (void)setupImageView{
    
    _index = 0;
    _isDragging = NO;
    self.leftImgV.image  = [UIImage imageNamed:_dataArr.lastObject];
    self.midImgV.image   = [UIImage imageNamed:_dataArr[0]];
    self.rightImgV.image = [UIImage imageNamed:_dataArr[1]];
}
//手势事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    if (self.ClickIndexBlock) {
        
        self.ClickIndexBlock(_index);
    }
}
//创建timer
- (void)creatTimer{
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:Times target:self selector:@selector(timerModth) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}
//取消timer
- (void)dismissTimer{
    
    if (_timer) {
        
        [_timer invalidate];
        _timer = nil;
    }
}
//定时器方法
- (void)timerModth{
    
    [self.scrollView setContentOffset:CGPointMake(Width*2, 0) animated:YES];
}
//scrollView代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self creatTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self dismissTimer];
    _isDragging = YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x >= Width*2 && _isDragging == NO) {
        
        _index ++;
        
        if (_index >= _dataArr.count) {
            
            _index = 0;
        }
        self.pageControl.currentPage = _index;
        [self indexForIamge];
        [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
    }
}
//手拖动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger pNum = scrollView.contentOffset.x/Width;
    _isDragging = NO;
    if (pNum == 2) {
        
        _index ++;
       
        if (_index >= _dataArr.count) {
            
            _index = 0;
        }
        [self indexForIamge];
    }
    else if (pNum == 0){
        
        _index --;

        if (_index == 0){
            
            [self setupImageView];
        }
        if (_index < 0) {
            
            _index = _dataArr.count-1;
        }
        [self indexForIamge];
    }
    self.pageControl.currentPage = _index;
    scrollView.contentOffset = CGPointMake(Width, 0);
}
//根据index展现相应的图片
- (void)indexForIamge{
    
    self.midImgV.image   = [UIImage imageNamed:_dataArr[_index]];
    
    if (_index == 0) {
        
        self.leftImgV.image  = [UIImage imageNamed:_dataArr.lastObject];
    }else{
        
        self.leftImgV.image  = [UIImage imageNamed:_dataArr[_index-1]];
    }
 
    if (_index == _dataArr.count-1) {
        
        self.rightImgV.image = [UIImage imageNamed:_dataArr[0]];
    }else{
        
        self.rightImgV.image = [UIImage imageNamed:_dataArr[_index+1]];
    }

}
//懒加载
- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Height-30, Width, 30)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = _dataArr.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}
- (UIImageView *)leftImgV{
    
    if (!_leftImgV) {
        
        _leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _leftImgV.userInteractionEnabled = YES;
    }
    return _leftImgV;
}
- (UIImageView *)midImgV{
    
    if (!_midImgV) {
        
        _midImgV = [[UIImageView alloc] initWithFrame:CGRectMake(Width, 0, Width, Height)];
        _midImgV.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.midImgV addGestureRecognizer:tap];
    }
    return _midImgV;
}
- (UIImageView *)rightImgV{
    
    if (!_rightImgV) {
        
        _rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(Width*2, 0, Width, Height)];
        _rightImgV.userInteractionEnabled = YES;
    }
    return _rightImgV;
}

@end




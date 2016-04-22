//
//  ViewController.m
//  FXImageScroll
//
//  Created by Benniu15 on 16/4/21.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "ViewController.h"
#import "FXImageWheel.h"
#import "FXImageCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}

- (void)setupView{
    
    NSArray * arr = [NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",nil];
    
    //1.正常改变scrollView的ContentOffset
    FXImageWheel * ff = [[FXImageWheel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250) withDataArray:arr];
    [self.view addSubview:ff];
    ff.ClickIndexBlock = ^(NSInteger index){
        
        NSLog(@"点击了：%ld",index);
    };
    
    //2.使用collectionView，改变数组顺序
    FXImageCollectionView * imgColl = [[FXImageCollectionView alloc] initWithFrame:CGRectMake(0, 320, self.view.frame.size.width, 200) withDataArray:arr];
    [self.view addSubview:imgColl];
}


@end



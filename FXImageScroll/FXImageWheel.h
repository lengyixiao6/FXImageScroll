//
//  FXImageWheel.h
//  BBB
//
//  Created by Benniu15 on 16/4/21.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXImageWheel : UIView

@property (nonatomic, copy) void(^ClickIndexBlock)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;

@end

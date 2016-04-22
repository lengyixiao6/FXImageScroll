//
//  FXImageWheelCell.m
//  BBB
//
//  Created by Benniu15 on 16/4/21.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "FXImageWheelCell.h"

@implementation FXImageWheelCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imgView];
    }
    return self;
}

@end

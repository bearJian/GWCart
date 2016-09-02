//
//  XJCircleButton.m
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCircleButton.h"

@implementation XJCircleButton

-(void)awakeFromNib{
    
// 初始化一个圆角按钮
    // 设置边框宽度
    self.layer.borderWidth = 1;
    
    // 设置边框颜色
    self.layer.borderColor = [UIColor blueColor].CGColor;
    
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
}

@end

//
//  XJTableViewCell.m
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJTableViewCell.h"
#import "XJShopItem.h"
#import "XJCircleButton.h"

@interface XJTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet XJCircleButton *minusBtn;

@end

@implementation XJTableViewCell


- (void)awakeFromNib {
    
}

// 给模型赋值
-(void)setShopItem:(XJShopItem *)shopItem{
    _shopItem = shopItem;
    self.shopImage.image = [UIImage imageNamed:shopItem.image];
    self.shopName.text = shopItem.name;
    self.shopPrice.text = [NSString stringWithFormat:@"￥ %@",shopItem.money];
    // 解决cell 商品数量被复用的问题
    // 修改cell里面的属性不能通过修改控件的属性，通过修改模型
    self.countLable.text = [NSString stringWithFormat:@"%d",shopItem.count];
    //根据模型中的count，觉得减号按钮能否点击
    self.minusBtn.enabled = shopItem.count > 0;
}

/**
 *  点击减号
 */
- (IBAction)clickMinus:(id)sender {
    // 修改模型
    self.shopItem.count --;
    // 修改商品数量显示
    self.countLable.text = [NSString stringWithFormat:@"%d",self.shopItem.count];
    // count == 0时按钮不可点击
    if (self.shopItem.count == 0) {
        self.minusBtn.enabled = NO;
    }
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(clickMinusBtn:)]) {
        [self.delegate clickMinusBtn:self];
    }
}

/**
 *  点击加号
 */
- (IBAction)clickAdd:(id)sender {
    // 修改模型
    self.shopItem.count ++;
    // 修改商品数量显示
    self.countLable.text = [NSString stringWithFormat:@"%d",self.shopItem.count];
    // 点击加号，让按钮为可使用状态
    self.minusBtn.enabled = YES;
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(clickAddBtn:)]) {
        [self.delegate clickAddBtn:self];
    }
}

@end

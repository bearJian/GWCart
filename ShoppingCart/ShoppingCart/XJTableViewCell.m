//
//  XJTableViewCell.m
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJTableViewCell.h"
#import "XJShopItem.h"

@interface XJTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;

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
}

@end

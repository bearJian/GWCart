//
//  XJTableViewCell.h
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJShopItem;

@interface XJTableViewCell : UITableViewCell
/**商品模型*/
@property (nonatomic, strong) XJShopItem *shopItem;
@end

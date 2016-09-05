//
//  XJTableViewCell.h
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJShopItem,XJTableViewCell;

// 创建协议
@protocol XJTableViewCellDelegate <NSObject>
@optional
-(void)clickAddBtn:(XJTableViewCell *)cell;
-(void)clickMinusBtn:(XJTableViewCell *)cell;
@end
@interface XJTableViewCell : UITableViewCell
/**商品模型*/
@property (nonatomic, strong) XJShopItem *shopItem;
/**代理*/
@property (nonatomic, weak) id<XJTableViewCellDelegate>delegate;
@end

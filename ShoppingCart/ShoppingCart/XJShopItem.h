//
//  XJShopItem.h
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJShopItem : NSObject
/**商品名称*/
@property (nonatomic, strong) NSString *name;
/**商品价格*/
@property (nonatomic, strong) NSString *money;
/**商品图片*/
@property (nonatomic, strong) NSString *image;

/**记录购买商品的数量*/
@property (nonatomic, assign) int count;

@end

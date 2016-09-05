//
//  ViewController.m
//  ShoppingCart
//
//  Created by Dear on 16/9/2.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "ViewController.h"
#import "XJTableViewCell.h"
#import "XJShopItem.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDataSource,XJTableViewCellDelegate>
/**商品数据*/
@property (nonatomic, strong) NSArray *shopArray;
/**购买商品的总价*/
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/**结算按钮*/
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**购物车对象*/
@property (nonatomic, strong) NSMutableArray *shopCart;
@end

@implementation ViewController

// 懒加载
-(NSArray *)shopArray{
    
    if (_shopArray == nil) {
        // 字典数组 -> 模型
        _shopArray = [XJShopItem mj_objectArrayWithFilename:@"wine.plist"];
        // 监听模型 KVO
//        for (XJShopItem * item in _shopArray) {
//            [item addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        }
    }
    return _shopArray;
}

-(NSMutableArray *)shopCart{
    if (!_shopCart) {
        _shopCart = [NSMutableArray array];
    }
    return _shopCart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";

}

#pragma mark - KVO 监听的方法
/*
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(XJShopItem *)item change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 判断是增加商品还是做了减少商品的操作
    int new = [change[NSKeyValueChangeNewKey] intValue];
    int old = [change [NSKeyValueChangeOldKey] intValue];
    
    if (new > old) { // 增加商品 操作
        // 商品的价格 = 每增加一件商品，价格累加
        int totalPrice = self.totalPrice.text.intValue + item.money.intValue;
        // 计算总价
        self.totalPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 设置结算按钮的属性
        self.payBtn.enabled = YES;
    }else{ // 减少商品操作
        // 商品的价格 = 每减少一件商品，价格累减
        int totalPrice = self.totalPrice.text.intValue - item.money.intValue;
        // 计算总价
        self.totalPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 设置结算按钮的属性
        self.payBtn.enabled = totalPrice > 0;
    }
    
}
 */
/**
 *  结算商品
 */

#pragma mark - 实现代理方法
-(void)clickAddBtn:(XJTableViewCell *)cell{
    // 商品的价格 = 每增加一件商品，价格累加
    int totalPrice = self.totalPrice.text.intValue + cell.shopItem.money.intValue;
    // 计算总价
    self.totalPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 设置结算按钮的属性
    self.payBtn.enabled = YES;
    // 将商品放入创建的购物车里
    // 没有添加的,才添加
    if (![self.shopCart containsObject:cell.shopItem]) {
        [self.shopCart addObject:cell.shopItem];
    }

}
-(void)clickMinusBtn:(XJTableViewCell *)cell{
    // 商品的价格 = 每减少一件商品，价格累减
    int totalPrice = self.totalPrice.text.intValue - cell.shopItem.money.intValue;
    // 计算总价
    self.totalPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 设置结算按钮的属性
    self.payBtn.enabled = totalPrice > 0;
    // 移除数量为0的商品
    if (cell.shopItem.count == 0) {
        [self.shopCart removeObject:cell.shopItem];
    }
}


- (IBAction)payBtn:(id)sender {
   // 打印购买了哪些商品
    for (XJShopItem *item in self.shopArray) {
        if (item.count > 0) {
            NSLog(@"购买了%d件 %@,价格为%d元",item.count,item.name,item.money.intValue * item.count);
        }
    }
    NSLog(@"总价为%d元",self.totalPrice.text.intValue);
}
/**
 *  清空购物车
 */
- (IBAction)clearBtn:(id)sender {
    // 1.商品的数量为0
    // 修改模型
    for (XJShopItem *item in self.shopArray) {
        item.count = 0;
    }
    // 1.1刷新tableView,让商品数量为0
    [self.tableView reloadData];
    
    // 1.2修改总价显示为0
    self.totalPrice.text = @"0";
    
    // 1.3清空购物车
    [self.shopCart removeAllObjects];
    
    // 2.结算按钮变为不可点击状态
    self.payBtn.enabled = NO;
}



#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    XJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 设置代理
    cell.delegate = self;
    // 赋值
    cell.shopItem = self.shopArray[indexPath.row];
    return cell;
    
}

-(void)dealloc{
    // 移除监听对象
    for (XJShopItem *item in self.shopArray) {
        [item removeObserver:self forKeyPath:@"count"];
    }
}

@end

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

@interface ViewController ()<UITableViewDataSource>
/**商品数据*/
@property (nonatomic, strong) NSArray *shopArray;
/**购买商品的总价*/
@property (weak, nonatomic) IBOutlet UILabel *toatlPrice;
/**结算按钮*/
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

// 懒加载
-(NSArray *)shopArray{
    
    if (_shopArray == nil) {
        // 字典数组 -> 模型
        _shopArray = [XJShopItem mj_objectArrayWithFilename:@"wine.plist"];
        // 监听模型
        for (XJShopItem * item in _shopArray) {
            [item addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
    }
    
    return _shopArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";

}

#pragma mark - KVO 监听的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(XJShopItem *)item change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 判断是增加商品还是做了减少商品的操作
    int new = [change[NSKeyValueChangeNewKey] intValue];
    int old = [change [NSKeyValueChangeOldKey] intValue];
    
    if (new > old) { // 增加商品 操作
        // 商品的价格 = 每增加一件商品，价格累加
        int totalPrice = self.toatlPrice.text.intValue + item.money.intValue;
        // 计算总价
        self.toatlPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 设置结算按钮的属性
        self.payBtn.enabled = YES;
    }else{ // 减少商品操作
        // 商品的价格 = 每减少一件商品，价格累减
        int totalPrice = self.toatlPrice.text.intValue - item.money.intValue;
        // 计算总价
        self.toatlPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 设置结算按钮的属性
        self.payBtn.enabled = totalPrice > 0;
    }
    
}
/**
 *  结算商品
 */
- (IBAction)payBtn:(id)sender {
   // 打印购买了哪些商品
    for (XJShopItem *item in self.shopArray) {
        if (item.count > 0) {
            NSLog(@"购买了%d件 %@",item.count,item.name);
        }
    }
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
    self.toatlPrice.text = @"0";
    
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

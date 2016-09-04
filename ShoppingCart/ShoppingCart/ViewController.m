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

@end

@implementation ViewController

// 懒加载
-(NSArray *)shopArray{
    
    if (_shopArray == nil) {
        // 字典数组 -> 模型
        _shopArray = [XJShopItem mj_objectArrayWithFilename:@"wine.plist"];
    }
    
    return _shopArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minusClick:) name:@"minusClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addClick:) name:@"addClickNotification" object:nil];
    
}

#pragma mark - 监听通知的方法
-(void)minusClick:(NSNotification *)note{
    // 发布者
    XJTableViewCell *cell = note.object;
    // 商品的价格 = 每增加一件商品，价格累加
    int totalPrice = self.toatlPrice.text.intValue + cell.shopItem.money.intValue;
    // 计算总价
    self.toatlPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
    
}

-(void)addClick:(NSNotification *)note{
    // 发布者
    XJTableViewCell *cell = note.object;
    // 商品的价格 = 每减少一件商品，价格累减
    int totalPrice = self.toatlPrice.text.intValue - cell.shopItem.money.intValue;
    // 计算总价
    self.toatlPrice.text = [NSString stringWithFormat:@"%d",totalPrice];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

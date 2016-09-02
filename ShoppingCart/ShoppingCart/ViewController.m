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

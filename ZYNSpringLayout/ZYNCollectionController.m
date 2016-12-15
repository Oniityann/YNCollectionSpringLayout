//
//  ZYNCollectionController.m
//  ZYNSpringLayout
//
//  Created by 郑一楠 on 16/7/9.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import "ZYNCollectionController.h"
#import "ZYNSpringLayout.h"
#import "ZYNCollectionViewCell.h"
#import "ZYNModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#define BGColor [UIColor colorWithRed:56.0/255.0  green:51/255.0 blue:76/255.0 alpha:1.0]
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenBounds [UIScreen mainScreen].bounds

@interface ZYNCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static NSString *const reuseIdentifier = @"Cell";

@implementation ZYNCollectionController

- (AFHTTPSessionManager *)manager {
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGColor;
    
    ZYNSpringLayout *flowLayout = [[ZYNSpringLayout alloc] init];
    
//    flowLayout.itemSize = CGSizeMake(200, 44);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(25, 200, 200, 400) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = BGColor;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYNCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self handleData];
}

- (void)handleData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    params[@"gradeid"] = @"4001";
    params[@"account"] = @"18607165791";
    params[@"usertoken"] = @"";
    
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", @"text/xml", nil]];
    
    [self.manager GET:[NSString stringWithFormat:@"http://m.moregolden.com:8080/App_Class/Grammar/LevelTwo.aspx"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.menuArray = [ZYNModel mj_objectArrayWithKeyValuesArray:responseObject[@"LIST"]];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.menuArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ZYNModel *gs = self.menuArray[indexPath.item];
    
    cell.grammerSelect = gs;
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

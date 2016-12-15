//
//  ZYNCollectionViewCell.m
//  ZYNSpringLayout
//
//  Created by 郑一楠 on 16/7/9.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import "ZYNCollectionViewCell.h"
#import "ZYNModel.h"

@implementation ZYNCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGrammerSelect:(ZYNModel *)grammerSelect {
    _grammerSelect = grammerSelect;
}

@end

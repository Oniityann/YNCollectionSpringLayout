//
//  ZYNSpringLayout.m
//  ZYNSpringLayout
//
//  Created by 郑一楠 on 16/7/9.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import "ZYNSpringLayout.h"

// 拉伸距离, 值越小拉伸越大
static CGFloat const SpringFactor = 5;

// 修改 item 间距
static CGFloat const verticallySpacing = 5;

@implementation ZYNSpringLayout

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout {
    
    CGFloat cellWidth = self.collectionView.frame.size.width;
    CGFloat cellHeight = 30;
    
    self.itemSize = CGSizeMake(cellWidth, cellHeight);
    self.headerReferenceSize = CGSizeMake(cellWidth, verticallySpacing);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *attrsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    
    CGFloat numOfItems = [self.collectionView numberOfSections];
    
    // 计算拉伸间距
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        
        // cell 发生变化
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {
            
            CGRect cellRect = attr.frame;
            
            if (offsetY <= 0) {
                
                // 拉伸距离绝对值
                CGFloat distance = fabs(offsetY) / SpringFactor;
                cellRect.origin.y += offsetY + distance * (attr.indexPath.section + 1);
                
            } else if (bottomOffset > 0) {
                
                CGFloat distance = bottomOffset / SpringFactor;
                cellRect.origin.y += bottomOffset - distance * (numOfItems - attr.indexPath.section);
            }
            attr.frame = cellRect;
        }
    }
    
    return attrsArray;
}

@end

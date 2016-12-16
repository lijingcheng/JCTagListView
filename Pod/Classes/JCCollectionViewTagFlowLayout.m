//
//  JCCollectionViewTagFlowLayout.m
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCCollectionViewTagFlowLayout.h"

@interface JCCollectionViewTagFlowLayout()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation JCCollectionViewTagFlowLayout

- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.itemSize = CGSizeMake(100.0f, 26.0f);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _itemAttributes = [NSMutableArray array];
}

#pragma mark -

- (void)prepareLayout {
    [self.itemAttributes removeAllObjects];
    
    self.contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self itemSizeForIndexPath:indexPath];
        
        if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    self.contentHeight += self.sectionInset.bottom;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark -

- (id<UICollectionViewDelegateFlowLayout>)delegate {
    if (!_delegate) {
        _delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
   
    return self.itemSize;
}

- (CGFloat)calculateContentHeight:(NSArray *)tags {
    CGFloat contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    for (NSInteger i = 0; i < tags.count; i++) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - self.sectionInset.left - self.sectionInset.right, self.itemSize.height);
        
        CGRect frame = [tags[i] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
        
        CGSize itemSize = CGSizeMake(frame.size.width + 20.0f, self.itemSize.height);
        
        if ((originX + itemSize.width + self.sectionInset.right/2) > [UIScreen mainScreen].bounds.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    contentHeight += self.sectionInset.bottom;
    
    return contentHeight;
}

@end

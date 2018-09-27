//
//  JCTagListViewFlowLayout.m
//  JCTagListView
//
//  Created by 李京城 on 2018/9/25.
//

#import "JCTagListViewFlowLayout.h"

@interface JCTagListViewFlowLayout()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation JCTagListViewFlowLayout

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
    _itemAttributes = [NSMutableArray array];
}

#pragma mark -

- (void)prepareLayout {
    [self.itemAttributes removeAllObjects];
    
    self.contentHeight = 0;
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        if ( i == 0) {
            self.contentHeight += itemSize.height;
        }
        
        if ((originX + itemSize.width) > self.collectionView.frame.size.width) {
            originX = 0;
            originY += (self.minimumLineSpacing + itemSize.height);
            
            self.contentHeight += (self.minimumLineSpacing + itemSize.height);
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += (self.minimumInteritemSpacing + itemSize.width);
    }
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

@end

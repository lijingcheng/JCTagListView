//
//  JCTagListView.m
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCTagListView.h"
#import "JCTagCell.h"
#import "JCTagListViewFlowLayout.h"

@interface JCTagListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *testLabel; // Used to calculate text height

@property (nonatomic, copy) JCTagListViewBlock selectedBlock;

@end

@implementation JCTagListView

static NSString * const reuseIdentifier = @"tagListViewItemId";

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

- (void)setup {
    _tags = [NSMutableArray array];
    _selectedTags = [NSMutableArray array];
    _selectedTagsIndex = [NSMutableArray array];
    
    _tagItemSpacing = 10.0f;
    _tagLineSpacing = 10.0f;
    _tagCornerRadius = 10.0f;
    _tagBorderWidth = 0.5f;
    _tagContentInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    _tagBorderColor = [UIColor lightGrayColor];
    _tagSelectedBorderColor = [UIColor lightGrayColor];
    _tagTextColor = [UIColor darkGrayColor];
    _tagSelectedTextColor = [UIColor darkGrayColor];
    _tagBackgroundColor = [UIColor whiteColor];
    _tagSelectedBackgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];

    _supportSelected = NO;
    _supportMultipleSelected = NO;
    
    _tagFont = [UIFont systemFontOfSize:14.0];

    [self addSubview:self.collectionView];
}

#pragma mark - public method

- (void)didSelectItem:(JCTagListViewBlock)block {
    self.selectedBlock = block;
}

- (void)reloadData {
    [_selectedTagsIndex removeAllObjects];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self textContentSize:self.tags[indexPath.item]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = self.tagCornerRadius;
    cell.layer.borderWidth = self.tagBorderWidth;

    cell.contentInset = self.tagContentInset;
    
    cell.textLabel.text = self.tags[indexPath.item];
    cell.textLabel.font = self.tagFont;
    
    if (self.supportSelected && [self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.layer.borderColor = self.tagSelectedBorderColor.CGColor;
        cell.textLabel.textColor = self.tagSelectedTextColor;
        cell.layer.backgroundColor = self.tagSelectedBackgroundColor.CGColor;
        
        [_selectedTagsIndex addObject:@(indexPath.item)];
    } else {
        cell.layer.borderColor = self.tagBorderColor.CGColor;
        cell.textLabel.textColor = self.tagTextColor;
        cell.layer.backgroundColor = self.tagBackgroundColor.CGColor;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.supportSelected) {
        if (self.supportMultipleSelected) {
            if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
                [self.selectedTags removeObject:self.tags[indexPath.item]];
            } else {
                [self.selectedTags addObject:self.tags[indexPath.item]];
            }
        } else {
            self.selectedTags = @[self.tags[indexPath.item]].mutableCopy;
        }
        
        [self reloadData];

        if (self.selectedBlock) {
            self.selectedBlock(indexPath.item);
        }
    }
}

#pragma mark - setter/getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        JCTagListViewFlowLayout *layout = [[JCTagListViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = self.tagItemSpacing;
        layout.minimumLineSpacing = self.tagLineSpacing;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = self.backgroundColor;
        [_collectionView registerClass:[JCTagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return _collectionView;
}

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    return _testLabel;
}

- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    
    [self reloadData];
}

- (void)setSelectedTags:(NSMutableArray *)selectedTags {
    _selectedTags = selectedTags;
    
    [self reloadData];
}

- (void)setTagItemSpacing:(CGFloat)tagItemSpacing {
    _tagItemSpacing = tagItemSpacing;

    JCTagListViewFlowLayout *layout = (JCTagListViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = tagItemSpacing;
}

- (void)setTagLineSpacing:(CGFloat)tagLineSpacing {
    _tagLineSpacing = tagLineSpacing;

    JCTagListViewFlowLayout *layout = (JCTagListViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = tagLineSpacing;
}

- (CGFloat)contentHeight {
    CGFloat contentHeight = 0;
    
    CGFloat originX = 0;
    CGFloat originY = 0;

    for (NSInteger i = 0; i < self.tags.count; i++) {
        CGSize itemSize = [self textContentSize:self.tags[i]];
  
        if ( i == 0) {
            contentHeight += itemSize.height;
        }
        
        if ((originX + itemSize.width) > self.collectionView.frame.size.width) {
            originX = 0;
            originY += (self.tagLineSpacing + itemSize.height);
            
            contentHeight += (self.tagLineSpacing + itemSize.height);
        }
        
        originX += (self.tagItemSpacing + itemSize.width);
    }
    
    return contentHeight;
}

#pragma mark - private method

- (CGSize)textContentSize:(NSString *)text {
    self.testLabel.font = self.tagFont;
    self.testLabel.text = text;
    [self.testLabel sizeToFit];
    
    CGFloat labelWidth = MIN(self.collectionView.frame.size.width - self.tagContentInset.left - self.tagContentInset.right, ceil(self.testLabel.frame.size.width));
    
    return CGSizeMake(labelWidth + self.tagContentInset.left + self.tagContentInset.right , ceil(self.testLabel.frame.size.height) + self.tagContentInset.top + self.tagContentInset.bottom);
}

@end

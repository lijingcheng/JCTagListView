//
//  JCTagListView.m
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCTagListView.h"
#import "JCTagCell.h"
#import "JCCollectionViewTagFlowLayout.h"

@interface JCTagListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) JCTagListViewBlock selectedBlock;

@end

@implementation JCTagListView

static NSString * const reuseIdentifier = @"tagListViewItemId";

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

- (void)setup
{
    _selectedTags = [NSMutableArray array];
    
    self.tags = [NSMutableArray array];
    
    JCCollectionViewTagFlowLayout *layout = [[JCCollectionViewTagFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[JCTagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:self.collectionView];
}

- (void)setCompletionBlockWithSelected:(JCTagListViewBlock)completionBlock
{
    self.selectedBlock = completionBlock;
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCCollectionViewTagFlowLayout *layout = (JCCollectionViewTagFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = [self.tags[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
    
    return CGSizeMake(frame.size.width + 20.0f, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.title = self.tags[indexPath.item];
    if (self.canSelectedTags) {
        if ([_selectedTags containsObject:self.tags[indexPath.item]]) {
            cell.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
        }
    }
    return cell;
}
- (void) handleCellSelection:(JCTagCell*)cell indexPathOfCell:(NSIndexPath *)indexPath {
    
    if (self.canSelectedTags) {
        
        if ([_selectedTags containsObject:self.tags[indexPath.item]]) {
            cell.backgroundColor = [UIColor whiteColor];
            
            [_selectedTags removeObject:self.tags[indexPath.item]];
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
            
            [_selectedTags addObject:self.tags[indexPath.item]];
        }
    }
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.item);
    }

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JCTagCell *cell = (JCTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self handleCellSelection:cell indexPathOfCell:indexPath];
}

@end

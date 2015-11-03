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

@property (nonatomic, copy) JCTagListViewBlock seletedBlock;

@end

@implementation JCTagListView

static NSString * const reuseIdentifier = @"tagListViewItemId";

@synthesize tagStrokeColor = _tagStrokeColor;

-(void)setTextColor:(UIColor *)tagStrokeColor
{
    _tagStrokeColor = tagStrokeColor;
}

-(UIColor *) tagStrokeColor
{
    if(_tagStrokeColor){
        return _tagStrokeColor;
    }else{
        return [UIColor lightGrayColor];
    }
}


@synthesize tagTextColor = _tagTextColor;

-(void)setTagTextColor:(UIColor *)tagTextColor
{
    _tagTextColor = tagTextColor;
}

-(UIColor *) tagTextColor
{
    if(_tagTextColor){
        return _tagTextColor;
    }else{
        return [UIColor whiteColor];
    }
}

@synthesize tagBackgroundColor = _tagBackgroundColor;


-(void)setTagBackgroundColor:(UIColor *)tagBackgroundColor
{
    _tagBackgroundColor = tagBackgroundColor;
}

-(UIColor *) tagBackgroundColor
{
    if(_tagBackgroundColor){
        return _tagBackgroundColor;
    }else{
        return [UIColor clearColor];
    }
}

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
    _seletedTags = [NSMutableArray array];
    
    self.tags = [NSMutableArray array];
    
    self.tagStrokeColor = [UIColor darkGrayColor];
    self.tagCornerRadius = 10.0f;
    
    JCCollectionViewTagFlowLayout *layout = [[JCCollectionViewTagFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[JCTagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:self.collectionView];
}

- (void)setCompletionBlockWithSeleted:(JCTagListViewBlock)completionBlock
{
    self.seletedBlock = completionBlock;
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
    cell.backgroundColor = self.tagBackgroundColor;
    cell.layer.borderColor = self.tagStrokeColor.CGColor;
    cell.layer.cornerRadius = self.tagCornerRadius;
    cell.titleLabel.text = self.tags[indexPath.item];
    cell.titleLabel.textColor = self.tagTextColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.canSelectTags) {
        JCTagCell *cell = (JCTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if ([_seletedTags containsObject:self.tags[indexPath.item]]) {
            cell.backgroundColor = [UIColor clearColor];
            
            [_seletedTags removeObject:self.tags[indexPath.item]];
        }
        else {
            cell.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
            
            [_seletedTags addObject:self.tags[indexPath.item]];
        }
    }
    
    if (self.seletedBlock) {
        self.seletedBlock(indexPath.item);
    }
}

@end

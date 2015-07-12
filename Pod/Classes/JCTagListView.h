//
//  JCTagListView.h
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCTagCell.h"

typedef void (^JCTagListViewBlock)(NSInteger index);

@interface JCTagListView : UIView

@property (nonatomic, assign) BOOL canSelectedTags;

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong, readonly) NSMutableArray *selectedTags;

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setCompletionBlockWithSelected:(JCTagListViewBlock)completionBlock;
- (void) handleCellSelection:(JCTagCell*)cell indexPathOfCell:(NSIndexPath *)indexPath;
@end

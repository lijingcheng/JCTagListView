//
//  JCTagListView.h
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JCTagListViewBlock)(NSInteger index);

@interface JCTagListView : UIView

@property (nonatomic, strong) UIColor *tagStrokeColor;
@property (nonatomic, strong) UIColor *tagTextColor;
@property (nonatomic, strong) UIColor *tagBackgroundColor;
@property (nonatomic, assign) CGFloat tagCornerRadius;

@property (nonatomic, assign) BOOL canSelectTags;

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong, readonly) NSMutableArray *seletedTags;

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setCompletionBlockWithSeleted:(JCTagListViewBlock)completionBlock;

@end

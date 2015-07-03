//
//  JCTagListView.h
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCTagListView : UIView

@property (nonatomic, assign) BOOL canRemoveTags;

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong, readonly) NSMutableArray *seletedTags;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

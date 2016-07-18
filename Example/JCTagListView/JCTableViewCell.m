//
//  JCTableViewCell.m
//  JCTagListView
//
//  Created by 李京城 on 16/7/18.
//  Copyright © 2016年 lijingcheng. All rights reserved.
//

#import "JCTableViewCell.h"

@interface JCTableViewCell ()

@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;

@end

@implementation JCTableViewCell

- (void)setTags:(NSArray *)tags
{
    _tags = tags;
    
    self.tagListView.tags = [NSMutableArray arrayWithArray:tags];
}

@end

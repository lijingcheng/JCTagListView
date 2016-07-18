//
//  JCTableViewController.m
//  JCTagListView
//
//  Created by 李京城 on 16/7/18.
//  Copyright © 2016年 lijingcheng. All rights reserved.
//

#import "JCTableViewController.h"
#import "JCTableViewCell.h"
#import "JCCollectionViewTagFlowLayout.h"

@interface JCTableViewController ()

@property (nonatomic, copy) NSArray *allTags;
@property (nonatomic, strong) NSMutableArray *cellHeights;

@property (nonatomic, strong) JCCollectionViewTagFlowLayout *layout;

@end

@implementation JCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellHeights = [NSMutableArray array];
    self.layout = [[JCCollectionViewTagFlowLayout alloc] init];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.allTags = @[@[@"NSString", @"NSMutableString", @"NSArray", @"UIAlertView", @"UITapGestureRecognizer", @"IBOutlet", @"IBAction", @"id", @"UIView", @"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"UIPageControl"], @[@"UIActionSheet", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"NSSet", @"NSMutableSet", @"NSData", @"NSMutableData", @"NSDate", @"UICollectionView", @"UIViewController", @"NSCalendar"], @[@"UITextField", @"UITextView", @"UIImageView", @"UITableView"], @[@"UIButton", @"UILabel"]];
    
    for (NSArray *tags in self.allTags) {
        [self.cellHeights addObject:@([self.layout calculateContentHeight:tags])];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeights[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.tags = self.allTags[indexPath.row];
    
    return cell;
}

@end

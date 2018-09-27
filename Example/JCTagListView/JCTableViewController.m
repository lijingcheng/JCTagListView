//
//  JCTableViewController.m
//  JCTagListView_Example
//
//  Created by 李京城 on 2018/9/25.
//  Copyright © 2018年 lijingcheng. All rights reserved.
//

#import "JCTableViewController.h"
#import "JCTagListView.h"

@interface JCTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;
@end
@implementation JCTableViewCell
@end

@interface JCTableViewController ()

@property (nonatomic, copy) NSArray *allTags;

@property (nonatomic, strong) NSMutableArray *cellHeights;

@property (nonatomic, strong) JCTagListView *testTagListView; // Used to calculate text height

@end

@implementation JCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cellHeights = [NSMutableArray array];

    self.allTags = @[@[@"NSStNSStringNSStringNSStringNSStringNSStringNSStringNSStringring", @"NSMutableString", @"NSArray", @"UIAlertView", @"UITapGestureRecognizer", @"IBOutlet", @"IBAction", @"id", @"UIView", @"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"UIPageControl"], @[@"UIActionSheet", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"NSSet", @"NSMutableSet", @"NSData", @"NSMutableData", @"NSDate", @"UICollectionView", @"UIViewController", @"NSCalendar"], @[@"UITextField", @"UITextView", @"UIImageView", @"UITableView"], @[@"UIButton", @"UILabel"]];
    
    CGFloat cellPadding = 10.0f;
    
    for (NSArray<NSString *> *tags in self.allTags) {
        self.testTagListView.tags = tags;
        [self.cellHeights addObject:@(self.testTagListView.contentHeight + cellPadding * 2)];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellHeights[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.tagListView.tags = self.allTags[indexPath.row];
    
    return cell;
}

#pragma mark -

- (JCTagListView *)testTagListView {
    if (!_testTagListView) {
        _testTagListView = [[JCTagListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 0)];
    }
    
    return _testTagListView;
}

@end

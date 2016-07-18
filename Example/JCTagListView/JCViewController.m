//
//  JCViewController.m
//  JCTagListView
//
//  Created by lijingcheng on 07/03/2015.
//  Copyright (c) 2014 lijingcheng. All rights reserved.
//

#import "JCViewController.h"
#import "JCTagListView.h"
#import "JCTableViewController.h"

@interface JCViewController ()

@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;

@end

@implementation JCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tagListView.canSelectTags = YES;
//    self.tagListView.tagStrokeColor = [UIColor redColor];
//    self.tagListView.tagBackgroundColor = [UIColor orangeColor];
//    self.tagListView.tagTextColor = [UIColor greenColor];
//    self.tagListView.tagSelectedBackgroundColor = [UIColor yellowColor];
    self.tagListView.tagCornerRadius = 5.0f;
    
    [self.tagListView.tags addObjectsFromArray:@[@"NSString", @"NSMutableString", @"NSArray", @"UIAlertView", @"UITapGestureRecognizer", @"IBOutlet", @"IBAction", @"id", @"UIView", @"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"UIPageControl", @"UIActionSheet", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"NSSet", @"NSMutableSet", @"NSData", @"NSMutableData", @"NSDate", @"NSCalendar", @"UIButton", @"UILabel", @"UITextField", @"UITextView", @"UIImageView", @"UITableView", @"UICollectionView", @"UIViewController"]];
    [self.tagListView.selectedTags addObjectsFromArray:@[@"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"NSMutableData", @"NSDate", @"NSCalendar", @"UIButton", @"UILabel", @"UITextField", @"UITextView", @"UIImageView", @"UITableView", @"UICollectionView", @"UIViewController"]];
    
    [self.tagListView setCompletionBlockWithSelected:^(NSInteger index) {
        NSLog(@"______%ld______", (long)index);
    }];
}

#pragma mark - IBAction

- (IBAction)delete:(id)sender
{
    [self.tagListView.tags removeObjectsInArray:self.tagListView.selectedTags];
    [self.tagListView.selectedTags removeAllObjects];
    
    [self.tagListView.collectionView reloadData];
    
    JCTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JCTableViewController"];
    
    [self.navigationController pushViewController:tableVC animated:YES];
}

@end

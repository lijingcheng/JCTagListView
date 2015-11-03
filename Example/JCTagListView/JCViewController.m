//
//  JCViewController.m
//  JCTagListView
//
//  Created by lijingcheng on 07/03/2015.
//  Copyright (c) 2014 lijingcheng. All rights reserved.
//

#import "JCViewController.h"
#import "JCTagListView.h"

@interface JCViewController ()

@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;

@end

@implementation JCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tagListView.canSelectTags = YES;
    self.tagListView.tagStrokeColor = [UIColor redColor]; //(Optional)
    self.tagListView.tagBackgroundColor = [UIColor whiteColor]; //(Optional)
    self.tagListView.tagTextColor = [UIColor redColor]; //(Optional)
    self.tagListView.tagColor = [UIColor darkGrayColor];
    self.tagListView.tagCornerRadius = 5.0f;
    
    [self.tagListView.tags addObjectsFromArray:@[@"NSString", @"NSMutableString", @"NSArray", @"UIAlertView", @"UITapGestureRecognizer", @"IBOutlet", @"IBAction", @"id", @"UIView", @"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"UIPageControl", @"UIActionSheet", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"NSSet", @"NSMutableSet", @"NSData", @"NSMutableData", @"NSDate", @"NSCalendar", @"UIButton", @"UILabel", @"UITextField", @"UITextView", @"UIImageView", @"UITableView", @"UICollectionView", @"UIViewController"]];
    
    [self.tagListView setCompletionBlockWithSeleted:^(NSInteger index) {
        NSLog(@"______%ld______", (long)index);
    }];
}

#pragma mark - IBAction

- (IBAction)delete:(id)sender
{
    [self.tagListView.tags removeObjectsInArray:self.tagListView.seletedTags];
    [self.tagListView.seletedTags removeAllObjects];
    
    [self.tagListView.collectionView reloadData];
}

@end

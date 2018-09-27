//
//  JCViewController.m
//  JCTagListView
//
//  Created by lijingcheng on 09/25/2018.
//  Copyright (c) 2018 lijingcheng. All rights reserved.
//

#import "JCViewController.h"
#import "JCTableViewController.h"
#import "JCTagListView.h"

@interface JCViewController ()

@property (nonatomic, weak) IBOutlet JCTagListView *tagListView;

@end

@implementation JCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tagListView.supportSelected = YES;
    self.tagListView.supportMultipleSelected = YES;
    
    self.tagListView.tags = @[@"NSStNSStringNSStringNSStringNSStringNSStringNSStringNSStringring", @"NSMutableString", @"NSArray", @"UITapGestureRecognizer", @"IBOutlet", @"IBAction", @"id", @"UIView", @"UIStatusBar", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"UIPageControl", @"UIActionSheet", @"NSMutableArray", @"NSDictionary", @"NSMutableDictionary", @"NSSet", @"NSMutableSet", @"NSData", @"NSMutableData", @"NSDate", @"NSCalendar", @"UIButton", @"UILabel", @"UITextField", @"UITextView", @"UIImageView", @"UITableView", @"UICollectionView", @"UIViewController"];
    
    self.tagListView.selectedTags = @[@"NSMutableString", @"UITableViewController", @"UIStepper", @"UISegmentedControl", @"UICollectionViewController", @"UISearchBar", @"UIToolbar", @"NSMutableData", @"NSDate", @"NSCalendar", @"UIButton", @"UILabel", @"UITextField"].mutableCopy;
    
    [self.tagListView didSelectItem:^(NSInteger index) {
        NSLog(@"%@", @(index));
    }];
}

#pragma mark - IBAction

- (IBAction)selected:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Selected Index" message:[self.tagListView.selectedTagsIndex description] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction: [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)openTableViewController:(id)sender {
    JCTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"JCTableViewController"];
    
    [self.navigationController pushViewController:tableVC animated:YES];
}

@end

//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "Business.h"
#import "MainViewCell.h"
#import "FiltersViewController.h"

#import "UIImageView+AFNetworking.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"ujmvWxSOPi_XLLJHTMf2fg";
NSString * const kYelpConsumerSecret = @"_GU12eZeAhrotXktFVK2aOBiYes";
NSString * const kYelpToken = @"cVTesHHvHouftkminx3X15t5fGqD1Sp1";
NSString * const kYelpTokenSecret = @"WzM9njf77xDC7ItmCz2sAoTpbBQ";

@interface MainViewController () <FiltersViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIGestureRecognizer *gestureRecognizer;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) NSString *searchTerm;
@property (nonatomic, strong) NSMutableDictionary *filters;

- (IBAction)onTap:(id)sender;
- (void)fetchData;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        self.searchTerm = @"Sushi";
        [self fetchData];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainViewCell"  bundle:nil] forCellReuseIdentifier:@"MainViewCell"];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search";
    [self.searchBar sizeToFit];

    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(onFilterButton)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 8;
    filterButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItems = @[filterButton, space];
    self.navigationItem.titleView = self.searchBar;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainViewCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}
- (void)filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters {
    self.filters = [filters copy];
    self.searchTerm = @"";
    self.searchBar.text = @"";
    [self fetchData];
}

- (void)onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    [vc setAppliedFilters:self.filters];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.navigationBar.barTintColor = [UIColor redColor];
    nvc.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self presentViewController:nvc animated:YES completion: nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.filters.count) {
        [self.filters removeAllObjects];
    }
    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.searchTerm = searchText;
        [self fetchData];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (self.filters.count) {
      [self.filters removeAllObjects];
    }
    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.searchTerm = searchText;
        [self.view endEditing:YES];

        [self fetchData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (self.filters.count) {
        [self.filters removeAllObjects];
    }    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.searchTerm = searchText;
        [self.view endEditing:YES];

        [self fetchData];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
}

- (void)fetchData {
    [self.client searchWithTerm:self.searchTerm params:[self.filters copy] success:^(AFHTTPRequestOperation *operation, id response) {
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (IBAction)onTap:(id)sender {
    NSLog(@"tapping!");
    [self.view endEditing:YES];
}

@end

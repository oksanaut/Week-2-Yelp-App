//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewCell.h"
#import "FiltersViewController.h"

#import "UIImageView+AFNetworking.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"ujmvWxSOPi_XLLJHTMf2fg";
NSString * const kYelpConsumerSecret = @"_GU12eZeAhrotXktFVK2aOBiYes";
NSString * const kYelpToken = @"cVTesHHvHouftkminx3X15t5fGqD1Sp1";
NSString * const kYelpTokenSecret = @"WzM9njf77xDC7ItmCz2sAoTpbBQ";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *searchTerm;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        [self fetchData:@"Thai"];
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
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *business = self.data[indexPath.row];
    MainViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainViewCell"];
    
    cell.nameLabel.text = business[@"name"];
    
    NSInteger reviewCount = [business[@"review_count"] integerValue];
    cell.ratingsCountLabel.text = [NSString stringWithFormat:@"%@ %@%@", business[@"review_count"], @"Review", (reviewCount == 1 ? @"" : @"s")];
    
    cell.expenseLabel.text = [@"" stringByPaddingToLength:arc4random_uniform(5) withString: @"$" startingAtIndex:0];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@, %@", [business valueForKeyPath:@"location.display_address"][0], [business valueForKeyPath:@"location.neighborhoods"][0]];

    cell.tagsLabel.text = [business[@"categories"][0] componentsJoinedByString:@", "];
    [cell.posterView setImageWithURL:[NSURL URLWithString:business[@"image_url"]]];
    [cell.ratingView setImageWithURL:[NSURL URLWithString:business[@"rating_img_url_large"]]];
    
    return cell;
}

- (void)onFilterButton {
    
    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    UINavigationController *nfcs = [[UINavigationController alloc] initWithRootViewController:fvc];
    nfcs.navigationBar.barTintColor = [UIColor redColor];
    nfcs.navigationBar.backgroundColor = [UIColor whiteColor];
    [self presentViewController:nfcs animated:YES completion: nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self fetchData:searchText];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self fetchData:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    if (![searchText isEqual:self.searchTerm]) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self fetchData:searchText];
    }
}

- (void)fetchData:(NSString *)searchTerm {
    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
        self.data = response[@"businesses"];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (IBAction)onTap:(id)sender {
    NSLog(@"onTap!");
    [self.view endEditing:YES];
}

@end

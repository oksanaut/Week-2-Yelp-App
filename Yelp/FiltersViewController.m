//
//  FiltersViewController.m
//  Yelp
//
//  Created by Oksana Timonin on 23/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "FiltersViewCell.h"

@interface FiltersViewController () <FiltersViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *settings;
@property (strong, nonatomic) NSArray *sections;

@property (nonatomic, strong) NSMutableDictionary *appliedFilters;

@end

@implementation FiltersViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self) {
        NSDictionary *propertiesList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filters" ofType:@"plist"]];
        self.settings = propertiesList[@"sections"];
        self.sections = [self.settings allKeys];
        self.appliedFilters = [NSMutableDictionary dictionary];

        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(handleCancel)];
        UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(handleApply)];
        cancelButton.tintColor = [UIColor whiteColor];
        searchButton.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.rightBarButtonItem = searchButton;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.appliedFilters addEntriesFromDictionary:self.filters];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"FiltersViewCell"  bundle:nil] forCellReuseIdentifier:@"FiltersViewCell"];
        
        self.title = @"Filters";
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settings.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionID = [self.sections objectAtIndex:section];
    NSDictionary *setting = [self.settings objectForKey:sectionID];
    return setting[@"display_name"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *setting = [self.settings objectForKey:[self.sections objectAtIndex:section]];
    NSArray *options = setting[@"options"];
    return options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FiltersViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FiltersViewCell"];
    
    NSDictionary *section = [self.settings objectForKey:[self.sections objectAtIndex:indexPath.section]];
    NSArray *options = [section objectForKey:@"options"];
    NSDictionary *filter = [options objectAtIndex:indexPath.row];
    NSString *cellFilter = [self.sections objectAtIndex:indexPath.section];
    NSString *cellValue = filter[@"value"];
    cell.delegate = self;
    cell.filter = cellFilter;
    cell.value = cellValue;
    cell.label.text = filter[@"display_name"];
    cell.on = [[self.appliedFilters objectForKey:cellFilter] isEqualToString:cellValue];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [self toggleCellSwitch:(FiltersViewCell *)[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Private Methods

- (void)filtersViewCell:(FiltersViewCell *)cell didUpdate:(BOOL)value {
    [self toggleCellSwitch:cell];
}

- (void)toggleCellSwitch:(FiltersViewCell *)cell {
    NSString *filterValue = [self.appliedFilters objectForKey:cell.filter];
    if (filterValue && filterValue == cell.filter) {
        [self.appliedFilters removeObjectForKey:cell.filter];
    } else {
        [self.appliedFilters setValue:cell.value forKey:cell.filter];
    }
    [self.tableView reloadData];
}

- (void)handleApply {
    [self.delegate filtersViewController:self didChangeFilters:self.appliedFilters];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)handleCancel {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end

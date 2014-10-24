//
//  FiltersViewController.m
//  Yelp
//
//  Created by Oksana Timonin on 23/10/2014.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "FiltersViewCell.h"

@interface FiltersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *settings;
@property (strong, nonatomic) NSArray *sections;
@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *propertiesList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filters" ofType:@"plist"]];
    self.settings = propertiesList[@"sections"];
    self.sections = [self.settings allKeys];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FiltersViewCell"  bundle:nil] forCellReuseIdentifier:@"FiltersViewCell"];
    
    self.title = @"Filters";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(handleCancel)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(handleApply)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = searchButton;
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
    NSArray *options = [self.settings objectForKey:[self.sections objectAtIndex:section]];
    return options.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FiltersViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FiltersViewCell"];
    
    NSDictionary *section = [self.settings objectForKey:[self.sections objectAtIndex:indexPath.section]];
    NSArray *sectionOptions = [section[@"options"] allKeys];
    NSLog(@"sectionOptions objectAtIndex:indexPath.row %@", [sectionOptions objectAtIndex:indexPath.row]);
    
    if (sectionOptions.count) {
        NSDictionary *option = [section objectForKey:[sectionOptions objectAtIndex:indexPath.row]];
        cell.optionLabel.text = option[@"display_name"];
    }
    return cell;
    
}

- (void)handleApply {
    [self dismissViewControllerAnimated:true completion:nil];

}
- (void)handleCancel {
    [self dismissViewControllerAnimated:true completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

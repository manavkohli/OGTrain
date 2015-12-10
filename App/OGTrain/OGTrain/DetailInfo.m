//
//  DetailInfo.m
//  OGTrain
//
//  Created by Manav Kohli on 12/9/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "DetailInfo.h"
#import "ListResultsViewControllerTableViewController.h"
#import "YelpAPISample/YPAPISample.h"

@interface DetailInfo ()

@property (nonatomic, strong) NSMutableArray *business;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSNumber * isClosed;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * category;
//@property (nonatomic, retain) NSNumber * latitude;
//@property (nonatomic, retain) NSNumber * longitude;
//@property (nonatomic, retain) NSString * address;
//@property (nonatomic, retain) NSString * rating_img_url;
//@property (nonatomic, retain) NSNumber * reviewCount;
//@property (nonatomic, retain) NSString * snippet_img_url;
//@property (nonatomic, retain) NSString * snippet_text;

@end

@implementation DetailInfo

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.business count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.business[indexPath.row];
    
    return cell;
}

- (void) setInformation:(NSDictionary *)yelpInfo{
//    NSLog(@"this the dictionary BIOTCH %@", yelpInfo);
    self.business = [NSMutableArray arrayWithArray:@[@"Name: ", @"Rating: ", @"Is Closed: ", @"Phone: ", @"Category:"]];
    self.business[0] = [NSString stringWithFormat:@"%@ %@", self.business[0], yelpInfo[@"name"]];
    self.business[1] = [NSString stringWithFormat:@"%@ %@", self.business[1], yelpInfo[@"rating"]];
    self.business[2] = [NSString stringWithFormat:@"%@ %@", self.business[2], yelpInfo[@"is_closed"]];
    self.business[3] = [NSString stringWithFormat:@"%@ %@", self.business[3], yelpInfo[@"display_phone"]];
    self.business[4] = [NSString stringWithFormat:@"%@ %@", self.business[4], yelpInfo[@"categories"][0][0]];
    [self.tableView reloadData];
}


@end

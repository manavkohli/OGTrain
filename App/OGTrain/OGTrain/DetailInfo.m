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
@property (nonatomic, strong) NSArray *categoryIndices;
@property (nonatomic, strong) NSDictionary *yelpInfo;

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
    
    self.categoryIndices = @[
                             @"Name",
                             @"Rating",
                             @"Is Closed",
                             @"Phone",
                             @"Category"
                            ];

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.business count];
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 70;
    }
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.business[indexPath.row];
    
    if ([self.categoryIndices[indexPath.row] isEqual:@"Name"]) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
    }
    
    if ([self.categoryIndices[indexPath.row] isEqual:@"Is Closed"]) {
        if ([self.business[indexPath.row] isEqual:@"Open"]) {
            cell.textLabel.textColor = [UIColor greenColor];
        }
        else {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    if ([self.categoryIndices[indexPath.row] isEqual:@"Rating"]) {
        cell.textLabel.text = @"";
        NSURL *url = [NSURL URLWithString:self.business[indexPath.row]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        cell.imageView.image = img;
    }
    if ([self.categoryIndices[indexPath.row] isEqual:@"Phone"]) {
        if ([self.business[indexPath.row] isEqual:@""]) {
            cell.textLabel.text = @"Phone: Not Available";
        }
        else {
            cell.textLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneNumberLabelTap:)];
            [cell.textLabel addGestureRecognizer:tapGesture];
        }
    }
    
    return cell;
}

-(void)phoneNumberLabelTap:(UIGestureRecognizer *)sender
{
    NSString *number = ((UILabel *)sender.view).text;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",number]];
    [[UIApplication sharedApplication] openURL:phoneUrl];
}

- (void) setInformation:(NSDictionary *)yelpInfo {
//    NSLog(@"this the dictionary BIOTCH %@", yelpInfo);
    self.business = [NSMutableArray new];
    self.yelpInfo = yelpInfo;
    
    [self.business addObject:yelpInfo[@"name"]];
    [self.business addObject:yelpInfo[@"rating_img_url"] ];
    [self.business addObject:[yelpInfo[@"is_closed"] intValue] == 0 ? @"Open" : @"Closed"];
    [self.business addObject:yelpInfo[@"display_phone"] ?: @""];
    [self.business addObject:yelpInfo[@"categories"][0][0]];
}


@end

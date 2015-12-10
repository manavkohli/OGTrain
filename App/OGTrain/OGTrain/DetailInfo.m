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
    
    if ([self.categoryIndices[indexPath.row] isEqual:@"Is Closed"]) {
        if ([self.business[indexPath.row] isEqual:@"Open"]) {
            cell.textLabel.textColor = [UIColor greenColor];
        }
        else {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    
    if ([self.categoryIndices[indexPath.row] isEqual:@"Phone"]) {
        if (self.yelpInfo[@"phone"] == nil) {
            cell.textLabel.text = @"Phone: Not Available";
        }
    }
    
    return cell;
}

- (void) setInformation:(NSDictionary *)yelpInfo {
//    NSLog(@"this the dictionary BIOTCH %@", yelpInfo);
    self.business = [NSMutableArray arrayWithArray:@[@"Name: ", @"Rating: ", @"Is Closed: ", @"Phone: ", @"Category:"]];
    self.yelpInfo = yelpInfo;
    
    self.business[0] = [NSString stringWithFormat:@"%@ %@", self.business[0], yelpInfo[@"name"]];
    self.business[1] = [NSString stringWithFormat:@"%@ %@", self.business[1], yelpInfo[@"rating"]];
    self.business[2] = [yelpInfo[@"is_closed"] intValue] == 0 ? @"Open" : @"Closed";
    self.business[3] = [NSString stringWithFormat:@"%@ %@", self.business[3], yelpInfo[@"display_phone"]];
    self.business[4] = [NSString stringWithFormat:@"%@ %@", self.business[4], yelpInfo[@"categories"][0][0]];
    NSLog(@"DIZ BIZNESS %@", self.business);
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

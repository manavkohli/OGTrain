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

@property (nonatomic, strong) NSDictionary *yelp;
@property (nonatomic, strong) NSMutableArray *business;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSNumber * isClosed;
@property (nonatomic, retain) NSString * rating;

//@property (nonatomic, retain) NSString * image_url;
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
    
    self.business = [NSMutableArray arrayWithArray:@[@"Name: ", @"Rating: ", @"Is Closed: ", @"Phone: "]];
    
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
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.business[indexPath.row];
    
    return cell;
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

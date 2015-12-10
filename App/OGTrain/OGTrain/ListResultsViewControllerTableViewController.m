//
//  ListResultsViewControllerTableViewController.m
//  OGTrain
//
//  Created by Manav Kohli on 9/18/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "ListResultsViewControllerTableViewController.h"
#import "DetailInfo.h"
#import "YelpAPISample/YPAPISample.h"
#import "ResultsTableCell.h"

@interface ListResultsViewControllerTableViewController ()

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSMutableArray *restaurantNames;
@property (nonatomic, strong) NSMutableArray *category;
@property (nonatomic, strong) NSMutableArray *rating;

@end

@implementation ListResultsViewControllerTableViewController

-(void) loadView {
//    [super loadView];
    [self populateTable];
    [super loadView];
}

- (void)viewDidLoad {
    //list to hold the names of ther restaurants
    self.restaurantNames = [[NSMutableArray alloc] init];
    self.category = [[NSMutableArray alloc] init];
    self.rating = [[NSMutableArray alloc] init];
    self.bizResults =[[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    

    
    
//    [button addTarget:self
//               action:@selector(aMethod:)
//    forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Show View" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    [table addSubview:button];
}

- (void)populateTable {
    //default search information
    NSString *defaultTerm = @"dinner";
    NSString *defaultLocation = @"San Francisco, CA";
    NSString *defaultRadius = @"2";
    NSString *defaultNumberOfResults = @"20";
    NSString *defaultCategory = @"Food";
    
    //TODO: Create method so that you can change these
    
    YPAPISample *YelpAPI = [[YPAPISample alloc] init];
    
    [YelpAPI listResults:defaultTerm
                location:defaultLocation
                  radius:defaultRadius
                 results:defaultNumberOfResults
                category:defaultCategory
       completionHandler:^(NSArray *bizArray, NSError *error) {
           
           if (error) {
               NSLog(@"An error happened during the request: %@", error);
           } else if (bizArray) {
               self.bizResults = bizArray;
               for(int i = 0; i < [bizArray count]; i++){
                   [self.category addObject:bizArray[i][@"categories"][0][0]];
                   [self.category addObject:bizArray[i][@"rating"]];
                   [self.restaurantNames addObject:bizArray[i][@"name"]];
                   
               }
               NSLog(@"in call block");
               NSLog(@"Name List: \n %@", self.restaurantNames);
               NSLog(@"Category List: \n %@", self.category);
               [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            }
            else {
               NSLog(@"No business was found");
           }
           
       }];
    NSLog(@"after call block");
    NSLog(@"Name List: \n %@", self.restaurantNames);
    NSLog(@"Category List: \n %@", self.category);
    
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

//Defines the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"number of cells: %lu", (unsigned long)[self.restaurantNames count]);
    return [self.restaurantNames count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailInfo *detailViewController = segue.destinationViewController;
        [detailViewController setInformation:self.bizResults[((NSIndexPath *)sender).row]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:indexPath];
}



//Defines what to display in each row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTbIdent = @"ResultsTableCell";
    ResultsTableCell *cell = (ResultsTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTbIdent];
    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTbIdent];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResultsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    //Configure the cell
    cell.nameLabel.text = self.bizResults[indexPath.row][@"name"];
    cell.categoryLabel.text = self.bizResults[indexPath.row][@"categories"][0][0];
//    cell.detailTextLabel.text = self.category[indexPath.row];
    return cell;
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"Results";
}

//specify table cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

@end

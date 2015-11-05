//
//  ListResultsViewControllerTableViewController.m
//  OGTrain
//
//  Created by Manav Kohli on 9/18/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "ListResultsViewControllerTableViewController.h"
#import "YelpAPISample/YPAPISample.h"

@interface ListResultsViewControllerTableViewController ()

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSMutableArray *restaurantNames;

@end

@implementation ListResultsViewControllerTableViewController

- (void)viewDidLoad {
    //list to hold the names of ther restaurants
    self.restaurantNames = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self populateTable];

    
    
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
       completionHandler:^(NSArray *bizArray, NSDictionary *bizJSON, NSError *error) {
           
           if (error) {
               NSLog(@"An error happened during the request: %@", error);
           } else if (bizArray) {
               //Add al
               for(int i = 0; i < [bizArray count]; i++){
                   [self.restaurantNames addObject:bizArray[i][0]];
               }
               NSLog(@"in call block");
               NSLog(@"Name List: \n %@", self.restaurantNames);
               [self.tableView reloadData];
               
           } else {
               NSLog(@"No business was found");
           }
           
       }];
    NSLog(@"after call block");
    NSLog(@"Name List: \n %@", self.restaurantNames);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"kToDetailViewSegue" sender:self];
}

//Defines what to display in each row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTbIdent = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTbIdent];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTbIdent];
    }
    
    //Configure the cell
    cell.textLabel.text = self.restaurantNames[indexPath.row];
    return cell;
}


@end

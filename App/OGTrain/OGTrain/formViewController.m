//
//  formViewController.m
//  OGTrain
//
//  Created by Julien Chien on 12/10/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "formViewController.h"
#import "ListResultsViewControllerTableViewController.h"

@interface formViewController ()

@end

@implementation formViewController

- (void)viewDidLoad {
    [self.navigationItem setTitle:@"Stop 'N 'Go!"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _goods = @[@"Restaurants", @"Bars", @"Malls", @"Zoos"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//******************
//UIPicker protocols
//- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//
//{
//    return  _goods.count;
//}
//
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return _goods[row];
//}
//end UIPickerProtocals
//******************


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ListResultsViewControllerTableViewController *listVC = [segue destinationViewController];
    listVC.searchItems = self.searchItems;
}

@synthesize stepper,radiusLabel;
- (IBAction)stepperAction:(id)sender {
    radiusLabel.text = [NSString stringWithFormat:@"%.f",stepper.value];
}

- (IBAction)searchButton:(id)sender {
    NSString *startingPoint = self.startLocation.text;
    NSLog(@"%@",startingPoint);
    NSString *endingPoint = self.endLocation.text;
    NSLog(@"%@",endingPoint);
    NSString *selectedGood = self.good.text;
    NSLog(@"%@",selectedGood);
    NSString *radiusString = radiusLabel.text;
    NSLog(@"%@",radiusString);
    
 
    self.searchItems = [NSDictionary dictionaryWithObjectsAndKeys:startingPoint, @"start", endingPoint, @"end", selectedGood, @"good", radiusString, @"radius", nil];
//   for(NSString *key in [self.searchItems allKeys]) {
//        NSLog(@"%@",[self.searchItems objectForKey:key]);
//    }
    [self performSegueWithIdentifier: @"formToList" sender:nil];
    
}

@end

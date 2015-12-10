//
//  formViewController.h
//  OGTrain
//
//  Created by Julien Chien on 12/10/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface formViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *startLocation;
@property (strong, nonatomic) IBOutlet UITextField *endLocation;
@property (weak, nonatomic) IBOutlet UITextField *good;

@property (strong, nonatomic) IBOutlet UILabel *radiusLabel;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
- (IBAction)stepperAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) NSArray *goods;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *end;
@property (nonatomic) NSInteger *radius;

@property (strong, nonatomic) NSDictionary *searchItems;

- (IBAction)searchButton:(id)sender;


@end

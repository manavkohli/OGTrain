//
//  YelpDictionaryParser.m
//  OGTrain
//
//  Created by Dhruv Manchala on 10/29/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "YelpDictionaryParser.h"

@interface YelpDictionaryParser ()

@end

@implementation YelpDictionaryParser

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSString *)name:(NSDictionary *)business {
  
  return business[@"name"];
}

- (BOOL)coordinatesExist:(NSDictionary *)business {
  
  return [business valueForKeyPath:@"location.coordinate"];
}

- (double)latitude:(NSDictionary *)business {
  
  return [[business valueForKeyPath:@"location.coordinate.latitude"] doubleValue];
}

- (double)longitude:(NSDictionary *)business {
  
  return [[business valueForKeyPath:@"location.coordinate.longitude"] doubleValue];
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

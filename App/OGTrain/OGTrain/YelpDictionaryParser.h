//
//  YelpDictionaryParser.h
//  OGTrain
//
//  Created by Dhruv Manchala on 10/29/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YelpDictionaryParser : UIViewController

- (NSString *)name:(NSDictionary *)businessInfo;
- (BOOL)coordinatesExist:(NSDictionary *)businessInfo;
- (double)latitude:(NSDictionary *)business;
- (double)longitude:(NSDictionary *)business;

@end

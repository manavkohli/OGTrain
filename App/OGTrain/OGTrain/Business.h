//
//  Business.h
//  OGTrain
//
//  Created by Austin Abrams on 11/3/15.
//  Copyright © 2015 Manav Kohli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Business : NSManagedObject

@property (nonatomic, retain) NSArray * categories;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSNumber * isClosed;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * rating_img_url;
@property (nonatomic, retain) NSNumber * reviewCount;
@property (nonatomic, retain) NSString * snippet_img_url;
@property (nonatomic, retain) NSString * snippet_text;


@end

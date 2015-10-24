//
//  YPAPISample.m
//  YelpAPI

#import "YPAPISample.h"
#import <Foundation/Foundation.h>


/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"3";

@implementation YPAPISample

#pragma mark - Public

/**
 Returns an array of the top result names for a query
 Completion handler is used to identify HTTP response codes
 
 Arguments:
 term               -- Search term (e.g. "food", "restaurants"
 location           -- Location to search restaurants by
 radius             -- Radius to search for goods/services within
 results            -- Number of results to return
 category           -- Category of good/service
 */


- (void) listResults:(NSString *)term location:(NSString *)location radius:(NSString *)radius results:(NSString *)results category:(NSString*)category completionHandler:(void (^)(NSArray *bizResults,NSDictionary *searchResponseJSON, NSError *error))completionHandler {
    
    NSMutableArray *restArray = [[NSMutableArray alloc] init];
    
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"limit": results,
                             @"radius_filter": radius,
                             @"category": category
                             };
    

    
    //Send the request and start the session
    NSURLRequest* searchRequest = [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
    NSURLSession *session = [NSURLSession sharedSession];

    //Handle the request
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         [[NSArray alloc] init];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        // Request went through
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            //Contains a list of all the restaurants
            for(int i = 0; i < [businessArray count]; i=i+1){
                NSMutableArray *restResults = [[NSMutableArray alloc] initWithCapacity: 4];
                [restResults insertObject:businessArray[i][@"name"] atIndex:0];
                [restResults insertObject:businessArray[i][@"mobile_url"] atIndex:1];
                [restResults insertObject:businessArray[i][@"rating"] atIndex:2];
                [restResults insertObject:businessArray[i][@"location"][@"address"] atIndex:3];
                [restArray  insertObject:restResults atIndex:i];
                
//                NSString *name = businessArray[i][@"name"];
//                NSLog(@"Name: %@", name);
                
            }
        //return the array with the business information
        completionHandler(restArray, nil, error);
        }
        // response code != 200; there was an error
        else {
            completionHandler(restArray, nil, error);
        }
    }] resume];
    
}

@end

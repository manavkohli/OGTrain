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


- (void) listResults:(NSString *)location radius:(NSString *)radius results:(NSString *)results category:(NSString*)category completionHandler:(void (^)(NSArray *bizResults, NSError *error))completionHandler {
    
    NSDictionary *params = @{
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
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        // Request went through
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
        
        
        //return the array with the business information
        completionHandler(businessArray, error);
        }
        // response code != 200; there was an error
        else {
            NSLog(@"fuck you");
            completionHandler(nil, error);
        }
    }] resume];
    
}

@end

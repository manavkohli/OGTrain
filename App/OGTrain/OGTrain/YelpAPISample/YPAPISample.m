//
//  YPAPISample.m
//  YelpAPI

#import "YPAPISample.h"

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
 */

- (void) listResults:(NSString *)term location:(NSString *)location radius:(NSString *)radius results:(NSString *)results category:(NSString*)category completionHandler:(void (^)(NSDictionary *businessArray, NSError *error))completionHandler {

    
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
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        // Request went through
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //Third element in the response is the list of businesses
            NSDictionary *businessArray = searchResponseJSON[@"businesses"];
//            for(int i = 0; i < [businessArray length]; i++){
//                NSLog(@"%", [businessArray objectForKey:i][@"name"]);
//            }
            NSLog(@"%@", searchResponseJSON);
            NSLog(@"%@", businessArray);
//            NSLog(@"%@", businessArray[@"name"]);
            
            
            
//            if ([businessArray count] > 0) {
//                NSDictionary *firstBusiness = [businessArray firstObject];
//                NSString *firstBusinessID = firstBusiness[@"id"];
//                NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);
//                
//                [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
//            } else {
//                completionHandler(nil, error); // No business was found
//            }
        }
        // response code != 200; there was an error
        else {
            completionHandler(nil, error);
        }
    }] resume];
    
}

- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {

  NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);

  //Make a first request to get the search results with the passed term and location
  NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
  NSURLSession *session = [NSURLSession sharedSession];
  [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    if (!error && httpResponse.statusCode == 200) {

      NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      NSArray *businessArray = searchResponseJSON[@"businesses"];

      if ([businessArray count] > 0) {
        NSDictionary *firstBusiness = [businessArray firstObject];
        NSString *firstBusinessID = firstBusiness[@"id"];
        NSLog(@"%lu businesses found, querying business info for the top result: %@", (unsigned long)[businessArray count], firstBusinessID);

        [self queryBusinessInfoForBusinessId:firstBusinessID completionHandler:completionHandler];
      } else {
        completionHandler(nil, error); // No business was found
      }
    } else {
      completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
    }
  }] resume];
}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
  [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (!error && httpResponse.statusCode == 200) {
      NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

      completionHandler(businessResponseJSON, error);
    } else {
      completionHandler(nil, error);
    }
  }] resume];

}


#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA

 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
  NSDictionary *params = @{
                           @"term": term,
                           @"location": location,
                           @"limit": kSearchLimit
                           };

  return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations

 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {

  NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
  return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}

@end

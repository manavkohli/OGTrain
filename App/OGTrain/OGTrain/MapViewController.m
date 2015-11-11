//
//  MapViewController.m
//  OGTrain
//
//  Created by Dhruv Manchala on 10/29/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "MapViewController.h"

@import GoogleMaps;

#import "YelpDictionaryParser.h"
#import "YPAPISample.h"

@interface MapViewController () <GMSMapViewDelegate>

@property (strong, nonatomic) GMSMapView *mapView;
@property (nonatomic) BOOL firstLocationUpdate;
@property (strong, nonatomic) GMSPolyline *currentRoute;

@end

NSString * const kGoogleMapsRouteInfoRequestURL = @"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f";

@implementation MapViewController

- (void)viewDidLoad {
  
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  [super viewDidLoad];
  [self setMapView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) setMapView {
  
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                          longitude:151.2086
                                                               zoom:12];
  
  self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
  self.mapView.settings.compassButton = YES;
  self.mapView.settings.myLocationButton = YES;
  self.mapView.delegate = self;
  
  [self.mapView addObserver:self
                 forKeyPath:@"myLocation"
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
  
  self.view = self.mapView;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.mapView.myLocationEnabled = YES;
    [self drawResultPins];
  });
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  if (!self.firstLocationUpdate) {
    
    self.firstLocationUpdate = YES;
    CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
    self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:12];
  }
}

- (void)drawResultPins {
  
  NSLog(@"%s", __PRETTY_FUNCTION__);
  
  NSString *defaultTerm = @"food";
  NSString *defaultLocation = @"San Jose, CA";
  NSString *defaultRadius = @"20000";
  NSString *defaultNumberOfResults = @"20";
  NSString *defaultCategory = @"Food";
  
  [[YPAPISample new] listResults:defaultTerm
                        location:defaultLocation
                          radius:defaultRadius
                         results:defaultNumberOfResults
                        category:defaultCategory
               completionHandler:
   ^(NSDictionary *bizJSON, NSError *error) {
     
     if (error) {
       NSLog(@"An error happened during the request: %@", error);
       return;
     }
     
     dispatch_async(dispatch_get_main_queue(), ^{
       
       NSArray *businesses = bizJSON[@"businesses"];
       for (NSDictionary *business in businesses) {
           [self drawPin:business];
       }
     });
   }];
}

- (void)drawPin:(NSDictionary *)business {
  
  YelpDictionaryParser *parser = [YelpDictionaryParser new];
  
  CLLocationCoordinate2D position = CLLocationCoordinate2DMake([parser latitude:business],
                                                               [parser longitude:business]);
  GMSMarker *marker = [GMSMarker markerWithPosition:position];
  marker.title = [parser name:business];
  marker.userData = business;
  marker.map = self.mapView;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
  
  YelpDictionaryParser * parser = [YelpDictionaryParser new];
  
  NSString *urlString = [NSString stringWithFormat:kGoogleMapsRouteInfoRequestURL,
                         self.mapView.myLocation.coordinate.latitude,
                         self.mapView.myLocation.coordinate.longitude,
                         [parser latitude:marker.userData],
                         [parser longitude:marker.userData]];
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:NSOperationQueue.mainQueue
                         completionHandler:
   ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     
     NSDictionary *route = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:nil];

     [self drawRoute:route];
  }];
}

- (void)drawRoute:(NSDictionary *)route {
  
  GMSMutablePath *path = [GMSMutablePath new];
  NSArray *steps = [route valueForKeyPath:@"routes.legs.steps"][0][0];
  
  NSLog(@"%@", steps);
  
  for (NSDictionary *step in steps) {
    [path addCoordinate:[self coordinatesFromStep:step]];
  }
  
  self.currentRoute.map = nil;
  self.currentRoute = [GMSPolyline polylineWithPath:path];
  self.currentRoute.map = self.mapView;
}

- (CLLocationCoordinate2D)coordinatesFromStep:(NSDictionary *)step {
 
  return CLLocationCoordinate2DMake([[step valueForKeyPath:@"end_location.lat"] doubleValue],
                                    [[step valueForKeyPath:@"end_location.lng"] doubleValue]);
}

@end







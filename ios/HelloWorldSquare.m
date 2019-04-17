//  Created by react-native-create-bridge
#import <Foundation/Foundation.h>
#import "HelloWorldSquare.h"
#import <JWPlayer_iOS_SDK/JWPlayerController.h>
// import RCTEventDispatcher
#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#elif __has_include(“RCTEventDispatcher.h”)
#import “RCTEventDispatcher.h”
#else
#import “React/RCTEventDispatcher.h” // Required when used as a Pod in a Swift project
#endif


@implementation HelloWorldSquare : UIView  {

  RCTEventDispatcher *_eventDispatcher;
  UIView *_childView;
  JWConfig *config;
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  if ((self = [super init])) {
    NSLog(@"test26");
    _eventDispatcher = eventDispatcher;
    config = [[JWConfig alloc] init];
 
  
    // self.player.delegate = self;
  }
  return self;
}
- (void)layoutSubviews
{
  [super layoutSubviews];
  self.player.forceFullScreenOnLandscape = YES;
  self.player.forceLandscapeOnFullScreen = YES;
  self.player.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
  self.player.view.frame = self.bounds;
  self.player.view.frame =  CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  [self setAutoresizesSubviews:TRUE];
  [self addSubview:self.player.view];
}

- (void)setExampleProp:(NSDictionary *)exampleProp
{
  NSLog(@"test55");
  if(exampleProp){
   NSMutableArray *myPlaylist;
    int i=0;
    NSArray *myArray = [NSArray array];
    
   
    
    NSLog(@"myArray:\n%@", myArray);
    for (NSDictionary *playlist in exampleProp[@"playlist"]) {
      NSLog(@"playlist: %@", playlist[@"title"]);
      for (NSDictionary *sources in playlist[@"sources"]) {
        NSString *file=sources[@"file"];
        NSString *certificateUrl=sources[@"drm"][@"fairplay"][@"certificateUrl"];
        NSString *processSpcUrl=sources[@"drm"][@"fairplay"][@"processSpcUrl"];
        NSDictionary *headers=sources[@"drm"][@"fairplay"][@"licenseRequestHeaders"];
        JWPlaylistItem *item1 = [[JWPlaylistItem alloc] init];
        item1.file            = file;
        [myArray arrayByAddingObjectsFromArray:item1];
        for (NSDictionary *header in headers) {
          NSString *key=header[@"name"];
          NSString *value=header[@"value"];
          //TODO add Header
        }
      }
   //   myPlaylist[i]= item1;
      i++;
      
    }
     NSLog(@"------------------------------------------------");
    NSLog(@"test57 '%@'", myArray);
    NSLog(@"------------------------------------------------");
 //config.playlist = myPlaylist;
   config.file = @"https://content.jwplatform.com/manifests/yp34SRmf.m3u8";
    config.controls = YES;  //default
    config.playbackRateControls = TRUE;
    config.audioSwitchingEnabled = TRUE;
    config.stretching = TRUE;
    config.displayDescription = @"This is sample  video description";
    config.displayTitle = @"Cycling is good for health";
    self.player = [[JWPlayerController alloc] initWithConfig:config];
   
    self.layoutSubviews;
    self.player.delegate = self;
    
  }
  
}

- (void)onFullscreen:(JWEvent<JWFullscreenEvent> *)event
{
  if(self.onFullScreen)
  {
    self.onFullScreen(@{@"fullScreen":@(event.fullscreen)});
    NSLog(@"-=======================================ON FULLSCREEN x EVENT '%d'---------------------", event.fullscreen);
  }
}

@end

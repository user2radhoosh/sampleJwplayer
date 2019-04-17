//  Created by react-native-create-bridge

// import UIKit so you can subclass off UIView
#import <UIKit/UIKit.h>
#import <React/RCTBridge.h>
#import <JWPlayer_iOS_SDK/JWPlayerController.h>
#import <React/UIView+React.h>

@class RCTEventDispatcher;

@interface HelloWorldSquare : UIView
  // Define view properties here with @property
  @property (nonatomic, assign) NSDictionary *exampleProp;
  @property(nonatomic, strong) JWPlayerController *player;
  @property(nonatomic, assign) NSString *playList;
  @property (nonatomic, copy) RCTDirectEventBlock onFullScreen;
// Initializing with the event dispatcher allows us to communicate with JS

  // Initializing with the event dispatcher allows us to communicate with JS
  - (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end

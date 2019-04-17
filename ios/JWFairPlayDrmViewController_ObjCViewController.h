//
//  JWFairPlayDrmViewController_ObjCViewController.h
//  JWFairPlayDrm
//
//  Created by Amitai Blickstein on 4/10/19.
//  Copyright © 2019 Karim Mourra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWBasicVideoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JWFairPlayDrmViewController_ObjCViewController : JWBasicVideoViewController <JWDrmDataSource, NSURLSessionDelegate>

@end

NS_ASSUME_NONNULL_END

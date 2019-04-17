//
//  JWFairPlayDrmViewController_ObjCViewController.m
//  JWFairPlayDrm
//
//  Created by Amitai Blickstein on 4/10/19.
//  Copyright © 2019 Karim Mourra. All rights reserved.
//

#import "JWFairPlayDrmViewController_ObjCViewController.h"

@interface JWFairPlayDrmViewController_ObjCViewController ()

@property (strong, atomic) NSString *encryptedFile;
@property (strong, atomic) NSString *certificate;

@end

@implementation JWFairPlayDrmViewController_ObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player.drmDataSource = self;
    self.encryptedFile = @"http://fps.ezdrm.com/demo/video/ezdrm.m3u8";
    self.certificate = @"http://fps.ezdrm.com/demo/video/eleisure.cer";
}

- (void)onReady:(JWEvent<JWReadyEvent> *)event
{
    JWPlaylistItem *item = [JWPlaylistItem new];
    item.file = self.encryptedFile;
    [self.player load:@[item]];
}

- (NSURLSession *)session {
    NSURLSessionConfiguration* sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration;
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return session;
}

- (void)fetchAppIdentifierForRequest:(NSURL *)loadingRequestURL forEncryption:(JWEncryption)encryption withCompletion:(void (^)(NSData *))completion
{
    if (encryption == JWEncryptionFairPlay) {
        NSMutableURLRequest *request = [NSMutableURLRequest new];
        request.URL = [NSURL URLWithString:self.certificate];
        request.HTTPMethod = @"GET";
        NSURLSession *session = [self session];
        __block NSError *dataTaskError;
        NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                             {
                                                 completion(data);
                                                 [session finishTasksAndInvalidate];
                                                 dataTaskError = error;
                                             }];
        [getDataTask resume];
    }
}

-(void)fetchContentIdentifierForRequest:(NSURL *)loadingRequestURL forEncryption:(JWEncryption)encryption withCompletion:(void (^)(NSData *))completion
{
    if (encryption == JWEncryptionFairPlay) {
        NSString *assetId = loadingRequestURL.path;
        assetId = [assetId substringFromIndex:[assetId rangeOfString: @";"].location];
        
        
        NSData *assetIdData = [assetId dataUsingEncoding:NSUTF8StringEncoding];
//        [assetId cStringUsingEncoding:(NSStringEncoding.UTF8Char)];
//        NSData *assetIdData = [NSData dataWithBytes:nil length:0];
        completion(assetIdData);
    }
}

- (void)fetchContentKeyWithRequest:(NSData *)requestBytes forEncryption:(JWEncryption)encryption withCompletion:(void (^)(NSData *, NSDate *, NSString *))completion
{
    if (encryption == JWEncryptionFairPlay) {
        NSTimeInterval currentTime = NSTimeIntervalSince1970 * 1000.0;
        NSString *keyServerAddress = [NSString stringWithFormat:@"http://fps.ezdrm.com/api/licenses/09cc0377-6dd4-40cb-b09d-b582236e70fe?p1=%f", currentTime];
        NSURL *ksmURL = [NSURL URLWithString:keyServerAddress];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:ksmURL];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-type"];
        request.HTTPBody = requestBytes;
        NSURLSession *session = [self session];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            completion(data, nil, nil);
        }];
        [postDataTask resume];
    }
}

@end

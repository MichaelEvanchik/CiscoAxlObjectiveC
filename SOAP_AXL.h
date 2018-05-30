//
//  SOAP_AXL.h
//  SOAPEngine OSX
//
//  Created by mevanchik on 5/30/18.
//  Copyright © 2018 Michael Evanchik. All rights reserved.
//
//  todo list
//  NSData+Additions
//  XML response parser and delegate
//  unit tests


#import <Foundation/Foundation.h>

@interface SOAP_AXL : NSObject

FOUNDATION_EXPORT NSString *const _VersionHeader;
FOUNDATION_EXPORT NSString *const _SoapStartEnvelope;
FOUNDATION_EXPORT NSString *const _SoapEndEnvelope;
FOUNDATION_EXPORT NSString *const _Basic;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *password;
@property (readwrite, strong) NSString *action;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *authorization;
@property (readwrite, strong) NSData *soap;

- (void)connect;

- (id)initUrl:(NSString *)url initVersion:(NSString *)version initUser:(NSString *)user initPassword:(NSString *)password initAction:(NSString *)action  initSoap:(NSString *)soap;

@end

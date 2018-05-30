//
//  SOAP_AXL.m
//  SOAPEngine OSX
//
//  Created by mevanchik on 5/30/18.
//  Copyright © 2018 Michael Evanchik. All rights reserved.
//  1.0
//

#import "SOAP_AXL.h"

@implementation SOAP_AXL

NSString *const _VersionHeader = @"\"CUCM:DB ver=";
NSString *const _SoapStartEnvelope = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns=\"http://www.cisco.com/AXL/API/";
NSString *const _SoapEndEnvelope = @"</soapenv:Envelope>";
NSString *const _Basic = @"Basic ";

-(NSString *)connect{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setValue:self.authorization forHTTPHeaderField:@"Authorization"];
    //[request setValue:@"1.0" forHTTPHeaderField:@"ProtocolVersion"]; --not sure yet
    long len = [self.soap length];
    NSString* slen = [NSString stringWithFormat:@"%ld", len];
    [request addValue:slen forHTTPHeaderField:@"Content-Length"];
    [request addValue:self.action forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPBody:self.soap];
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error:%@", error);
            return;
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            if (statusCode != 200) {
                NSLog(@"BAD HTTP status code :%ld", (long)statusCode);
                return;
            }
        }
        
        NSMutableData *webData = [[NSMutableData alloc] init];
        [webData appendData:data];
        
        NSLog(@"Received bytes from the server :%lu", (unsigned long)[webData length]);
        NSMutableString *resultString = [[NSMutableString alloc] initWithBytes:[webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
        NSLog(@"result %@",resultString);
    }];
    return resultString;
}
                                      
                                      
                                      

-(id) initUrl:(NSString *)url initVersion:(NSString *)version initUser:(NSString *)user initPassword:(NSString *)password initAction:(NSString *)action initSoap:(NSString *)soap
{
    self = [super init];
    if(self){
        self.url = url;
        self.user = user;
        self.password = password;
        self.action = [NSString stringWithFormat: @"%@ %@ %@\"", _VersionHeader, version, action];
        NSString *soapMessage = [NSString stringWithString:soap];
        self.soap = [soapMessage dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", user, password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:(0)]];
        self.authorization = authValue;
    }
    return self;
}
@end

# CiscoAxlObjectiveC
Attempt for objective c class to communicate with Cisco Axl cucm... only prototype

//how to use and init

    SOAP_AXL *client = [[SOAP_AXL alloc] initUrl:(@"https://infoplus.com:8443/axl") initVersion:(@"8.5") initUser:(@"admin") initPassword:(@"pass") initAction:@"getPhone" initSoap:(@"")];
  
    NSString *soapMessage = [NSString stringWithString:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns=\"http://www.cisco.com/AXL/API/8.5\"><soapenv:Body><ns:getPhone><name>test3</name></ns:getPhone><soapenenv:Envelope>"];
    client.soap = [soapMessage dataUsingEncoding:NSUTF8StringEncoding];

    [client connect];


//  todo list

//  NSData+Additions for base64

//  XML response parser and delegate

//  lots of refactoring, clean up

//  unit tests

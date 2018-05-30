# CiscoAxlObjectiveC
Attempt for objective c class to communicate with Cisco Axl cucm... only prototype

//how to use and init

SOAP_AXL *client = [[SOAP_AXL alloc] initUrl:(@"https://web.com:8443/axl") initVersion:(@"8.5") initUser:(@"admin") initPassword:(@"pass") initAction:@"getPhone" initSoap:(@"<soap>")];
  
[client connect];


//  todo list

//  NSData+Additions for base64

//  XML response parser and delegate

//  lots of refactoring, clean up

//  unit tests

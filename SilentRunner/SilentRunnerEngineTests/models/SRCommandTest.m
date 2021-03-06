//
//  SRCommandTest.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/13/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SRClientPool.h"
#import "SRCommand.h"
#import "SRMockFabric.h"

@interface SRCommandTest : XCTestCase

@end

@implementation SRCommandTest


- (void)testSRCommandSuccsesfullParsing{
    NSDictionary* intput = @{
      @"commandId": @"UIApplication || app",
      @"method": @"application:openURL:options:",
      @"arguments": @[
              @{
                  @"class": @"NSURL",
                  @"properties": @[@{
                                        @"name":@"absoluteString",
                                        @"returnValue":@"https://github.com/andrewBatutin/SilentRunner"
                                    }
                                   ],
                  @"methods": @[
                          @{@"name":@"isFileReferenceURL", @"returnValue":@"1"}
                          ]
                  },
              @{
                  @"value": @{
                          @"opt1": @"test"
                          }
                  },
              @{
                  @"block": @{
                          @"returnValue":@"notUsed"
                          }
                  }
              ]
      };
    NSError* parseError = nil;
    SRCommand* realResult = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    XCTAssertNotNil(realResult);
}


- (void)testSRCommandSuccsesfullInvocationConstruct{
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    NSDictionary* intput = @{
                             @"commandId": @"NSMutableArray",
                             @"method": @"addObject:",
                             @"arguments": @[
                                     @{
                                         @"class": @"NSURL",
                                         @"methods": @[
                                                 @{
                                                     @"name": @"isFileReferenceURL",
                                                     @"returnValue": @"mock data"
                                                     },
                                                 @{
                                                     @"name": @"fileReferenceURL",
                                                     @"returnValue": @"mock path"
                                                     }
                                                 ]
                                         }
                                     ]                             };
    NSError* parseError = nil;
    SRCommand* entity = [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    NSInvocation* realResult = [entity commandInvocation];
    [realResult invoke];
    NSMutableArray* client =  [SRClientPool clientForTag:@"NSMutableArray"];
    XCTAssertTrue(client.count == 1);
}

- (void)testSRCommandInvalidCommandParsing{
    NSDictionary* intput = @{
                             @"commandId": @"UIApplication || app",
                             @"method": @"application:openURL:options:",
                             @"arguments": @[
                                     @{
                                         @"class": @"NSURL",
                                         @"properties": @[
                                                              @"absoluteString",
                                                              
                                                          ],
                                         @"methods": @[
                                                 @{@"name":@"isFileReferenceURL", @"returnValue":@"1"}
                                                 ]
                                         },
                                     @{
                                         @"value": @{
                                                 @"opt1": @"test"
                                                 }
                                         },
                                     @{
                                         @"class": @"block",
                                         @"methods": @[
                                                 @"[given(invoke) willReturn:\"smthng\"]"
                                                 ]
                                         }
                                     ]
                             };
    NSError* parseError = nil;
    [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    XCTAssertNotNil(parseError);
}

- (void)testSRCommandInvalidCommandParsingWithStaticMethod{
    NSDictionary* intput = @{
                             @"commandId": @"UIApplication || app",
                             @"method": @"application:openURL:options:",
                             @"arguments": @[
                                     @{
                                         @"class": @"NSURL",
                                         
                                         @"methods": @[
                                                 @{@"name":@"URLWithString:", @"returnValue":@"1"}
                                                 ]
                                         },
                                     @{
                                         @"value": @{
                                                 @"opt1": @"test"
                                                 }
                                         },
                                     @{
                                         @"class": @"block",
                                         @"methods": @[
                                                 @"[given(invoke) willReturn:\"smthng\"]"
                                                 ]
                                         }
                                     ]
                             };
    NSError* parseError = nil;
    [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    XCTAssertNotNil(parseError);
}

- (void)testSRCommandInvalidCommandParsingWithWrongMethodSign{
    NSDictionary* intput = @{
                             @"commandId": @"UIApplication || app",
                             @"method": @"application:openURL:options:",
                             @"arguments": @[
                                     @{
                                         @"class": @"NSURL",
                                         
                                         @"methods": @[
                                                 @{@"name":@"isFileReferenceURL:", @"returnValue":@"1"}
                                                 ]
                                         },
                                     @{
                                         @"value": @{
                                                 @"opt1": @"test"
                                                 }
                                         },
                                     @{
                                         @"class": @"block",
                                         @"methods": @[
                                                 @"[given(invoke) willReturn:\"smthng\"]"
                                                 ]
                                         }
                                     ]
                             };
    NSError* parseError = nil;
    [MTLJSONAdapter modelOfClass:SRCommand.class fromJSONDictionary:intput error:&parseError];
    XCTAssertNotNil(parseError);
}


@end

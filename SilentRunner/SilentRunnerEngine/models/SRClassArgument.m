//
//  SRClassArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRClassArgument.h"
#import "SRMockFabric.h"

@interface SRClassArgument ()

@end

@implementation SRClassArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{    
    return @{@"className":@"class",
             @"properties":@"properties",
             @"methods":@"methods"
             };
}

- (id)argumentValue{
    MKTBaseMockObject* model = [self createModelWithMethods:self.methods andProperties:self.properties];
    return model;
}

- (MKTBaseMockObject*)createModelWithMethods:(NSArray*)methods andProperties:(NSArray*)properties{
    Class modelClass = NSClassFromString(self.className);
    MKTObjectMock* object = [SRMockFabric mockWithClass:modelClass];
    for ( NSDictionary* model in methods ){
        [SRMockFabric addMethodsWithDictionary:model toModel:object withError:nil];
    }
    for ( NSDictionary* prop in properties ){
        [SRMockFabric addPropertiesWithDictionary:prop toModel:object];
    }
    return object;
}

@end

//
//  SRBlockArgument.m
//  SilentRunner
//
//  Created by andrew batutin on 12/14/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "SRBlockArgument.h"

@implementation SRBlockArgument

@synthesize argumentValue;

+ (NSDictionary*)JSONKeyPathsByPropertyKey{
    return @{
                @"methods":@"methods"
             };
}


@end
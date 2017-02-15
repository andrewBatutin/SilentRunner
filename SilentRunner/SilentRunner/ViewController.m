//
//  ViewController.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "ViewController.h"
#import "SRServer.h"
#import "SRServer+Utils.h"
#import "SRClientPool.h"
#import "SRCommandHandler.h"
#import "SRMessageHandler.h"

@interface ViewController ()
@property (nonatomic, strong) SRServer* serv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SRServer enableLogging];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    [SRClientPool addClient:[UIApplication sharedApplication].delegate forTag:@"app"];
    self.serv = [SRServer serverWithURL:@"ws://localhost:9000/chat" withMessageHandler:^(NSString * msg) {
        NSError* error = nil;
        SRCommand* command = (SRCommand*)[SRMessageHandler createCommandFromMessage:msg withError:^(NSError* error){
            [self.serv sendErrorMessage:error];
        }];
        [SRCommandHandler runCommand:command withError:&error];
        if ( error ){
            [self.serv sendErrorMessage:error];
        }        
    } withErrorHandler:^(NSError * error) {
        [self.serv sendErrorMessage:error];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)testAction:(id)sender {
    if ( self.serv.webSocket.readyState == SR_OPEN ){
        [self.serv webSocket:self.serv.webSocket didReceiveMessage:@"hi"];
    }
}

- (IBAction)runServer:(id)sender {
    if ( self.serv.webSocket.readyState == SR_CONNECTING ){
        [self.serv.webSocket open];
    }
}

@end

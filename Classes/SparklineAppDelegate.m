//
//  SparklineAppDelegate.m
//  Sparkline
//
//  Created by Ayal Spitz on 4/2/09.
//  Copyright Ayal Spitz 2009. All rights reserved.
//

#import "SparklineAppDelegate.h"

@implementation SparklineAppDelegate

@synthesize window, viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application { 
	[window addSubview:[viewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[viewController release];
    [window release];
    [super dealloc];
}


@end

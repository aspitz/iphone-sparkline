//
//  RootViewController.m
//  Sparkline
//
//  Created by iPhone Dev on 4/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import <stdlib.h>


@implementation RootViewController

@synthesize sparklineView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	int			dataLen = 20;
	int			r;
	CGFloat*	data = (CGFloat*) calloc (dataLen, sizeof(CGFloat));;
	for (int i = 0; i <= dataLen; i++){
		r = (arc4random() % 20) - 10;
		data[i] =  ((CGFloat)r);
	}
	
	[sparklineView debug];
	[sparklineView setNormalRangeMin:-10.0 max:0.0];
	[sparklineView setData:data len:dataLen min:-10.0 max:10.0];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[sparklineView dealloc];
    [super dealloc];
}


@end

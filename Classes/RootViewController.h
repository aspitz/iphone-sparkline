//
//  RootViewController.h
//  Sparkline
//
//  Created by Ayal Spitz on 4/2/09.
//  Copyright 2009 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SparklineView.h"

@interface RootViewController : UIViewController {
	SparklineView* sparklineView;
}

@property (nonatomic, retain) IBOutlet SparklineView* sparklineView;

@end

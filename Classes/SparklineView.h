//
//  SparklineView.h
//  Sparkline
//
//  Created by Ayal Spitz on 4/2/09.
//  Copyright 2009 Ayal Spitz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SparklineView : UIView {
	CGFloat*	lines;
	UIColor*	lineColor;
	CGFloat		lineWidth;
	UIColor*	dotColor;
	
	int			dataLen;
	CGFloat		dataMin, dataMax;
	
	bool		showNormalRange;
	UIColor*	normalRangeColor;
	CGFloat		normalMin, normalMax;
	
	bool		debug;
}

@property (nonatomic, retain) UIColor* lineColor;
@property (nonatomic, retain) UIColor* dotColor;
@property (nonatomic, retain) UIColor* normalRangeColor;

- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max;
- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max color:(UIColor *)color;

- (void)setLineWidth:(CGFloat)width;

- (void)setNormalRangeMin:(CGFloat) nMin max:(CGFloat)nMax;
- (void)setNormalRangeMin:(CGFloat) nMin max:(CGFloat)nMax color:(UIColor *)color;

- (void)debug;

@end

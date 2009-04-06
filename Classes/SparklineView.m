//
//  SparklineView.m
//  Sparkline
//
//  Created by Ayal Spitz on 4/2/09.
//  Copyright 2009 Ayal Spitz. All rights reserved.
//

#import "SparklineView.h"

@implementation SparklineView

@synthesize lineColor, dotColor, normalRangeColor;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
		showNormalRange = false;
		dotColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
		[self setLineWidth:0.5];
		debug = false;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		showNormalRange = false;
		dotColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
		[self setLineWidth:0.5];
		debug = false;
    }
    return self;
}

/**
 * setData - Sets the data to be rendered by this sparkline. This method defaults the line color to a dark gray.
 *  data - pointer to an array of CGFloats
 *  len - the number of elements in the data array
 *  min - the min value of the data to be presented by this sparkline
 *  max - the max value of the data to be presented by this sparkline
 **/
- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max{
	UIColor* color = [[UIColor alloc] initWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
	[self setData:data len:len min:min max:max color:color];
}

/**
 * setData - Sets the data to be rendered by this sparkline.
 *  data - pointer to an array of CGFloats
 *  len - the number of elements in the data array
 *  min - the min value of the data to be presented by this sparkline
 *  max - the max value of the data to be presented by this sparkline
 *  color - the color to use to draw the sparkline
 **/
- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max color:(UIColor *)color{
	dataLen = len;
	dataMin = min;
	dataMax = max;
	lineColor = color;
	
	lines = (CGFloat*) calloc (dataLen, sizeof(CGFloat));
	for(int i=0;i<dataLen;i++){ lines[i] = data[i]; }
}

/**
 * setLineWidth - Sets the width of the sparkline.
 *  width - The width of the sparkline. Anti-aliasing will handle fractional widths
 **/
- (void)setLineWidth:(CGFloat)width{ lineWidth = width; }

/**
 * setNormalRangeMin - Sets a normal rang that is rendered as a background box. This method defaults to a light gray.
 *  min - the min value of the normal range
 *  max - the max value of the normal range
 **/
- (void)setNormalRangeMin:(CGFloat)min max:(CGFloat)max{
	UIColor* color = [[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	[self setNormalRangeMin:min	max:max color:color];
}

/**
 * setNormalRangeMin - Sets a normal rang that is rendered as a background box.
 *  min - the min value of the normal range
 *  max - the max value of the normal range
 *  color - the color to use to paint the normal range
 **/
- (void)setNormalRangeMin:(CGFloat) min max:(CGFloat)max color:(UIColor*)color{
	normalMin = min;
	normalMax = max;
	normalRangeColor = color;
	showNormalRange = true;
}

/**
 * drawRect - Renders the actual sparkline
 *  rect - the rectangle in which the sparkline is to be rendered
 **/
- (void)drawRect:(CGRect)rect {
	// Check if the dataLen is not zero. This indicates that the user has set data for the sparkline to be rendered
	if (dataLen != 0){
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGFloat	height = rect.size.height;
		CGFloat width = rect.size.width;
		int dataSpan = dataMax - dataMin;
						
		CGPoint addLines[dataLen];
		// Compute the scaling factor between the scale of the data and the rendering rectangle
		CGFloat scaleX = (width - 2) / dataLen;
		CGFloat scaleY = (height - 2) / dataSpan;
		CGFloat x = 0.0, y = 0.0;
		
		// If the user has set a normal range
		if (showNormalRange){
			// Set the fill color
			CGContextSetFillColorWithColor(ctx, [normalRangeColor CGColor]);
			// Create a rectanle scaled to the scale of the rendering rectangle
			CGRect normalRect = CGRectMake(0, (height - 3) - ((normalMax - dataMin) * scaleY),
										 width, (normalMax - normalMin) * scaleY);
			// Render the rectangle in the current graphics context
			CGContextFillRect(ctx, normalRect);
		}
		
		// Convert the user data set to a rendering rectangle
		for (int i=0 ; i<=dataLen ; i++){
			// scale the x axis of the data set
			x = (i * scaleX);
			// scale the y axis of the data set and flip the y axis so that zero 
			//  is in the lower right hand corner of the rendering rectangle
			y = (height - 3) - ((lines[i] - dataMin) * scaleY);

			addLines[i] = CGPointMake(x,y);
		}

		CGContextAddLines(ctx, addLines, dataLen + 1);
		// Set the color of the sparkline
		CGContextSetStrokeColorWithColor(ctx, [lineColor CGColor]);
		// Set the line width of the sparkline
		CGContextSetLineWidth(ctx, lineWidth);
		// Render the sparkline
		CGContextStrokePath(ctx);
	
		// Create the rectangle for the sparkline end dot
		CGRect	endRect = CGRectMake(addLines[dataLen].x - 3, addLines[dataLen].y - 3, 5.0, 5.0);
		// Set the color of the sparkline end dot
		CGContextSetFillColorWithColor(ctx, [dotColor CGColor]);
		// Render the sparkline end dot
		CGContextFillEllipseInRect(ctx, endRect);

		// Render a bounding box for debugging purposes
		if (debug){
			CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0);
			CGContextStrokeRect(ctx, CGRectMake(0, 0, width, height));
			CGContextMoveToPoint(ctx, 0, (height/2) - 3);
			CGContextAddLineToPoint(ctx, width, (height/2) - 3);
		}
	}
}

- (void)debug{ debug = true; }

- (void)dealloc {
	[dotColor dealloc];
	[normalRangeColor dealloc];
	[lineColor dealloc];
    [super dealloc];
}


@end

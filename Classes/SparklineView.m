//
//  SparklineView.m
//  Sparkline
//
//  Created by iPhone Dev on 4/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SparklineView.h"

@implementation SparklineView

@synthesize lineColor, dotColor, normalRangeColor;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
		showNormalRange = false;
		dotColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
		[self setLineWidth:0.5];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		showNormalRange = false;
		dotColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
		[self setLineWidth:0.5];
    }
    return self;
}

- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max{
	UIColor* color = [[UIColor alloc] initWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
	[self setData:data len:len min:min max:max color:color];
}

- (void)setData:(CGFloat*)data len:(int)len min:(CGFloat)min max:(CGFloat)max color:(UIColor *)color{
	dataLen = len;
	dataMin = min;
	dataMax = max;
	lineColor = color;
	
	lines = (CGFloat*) calloc (dataLen, sizeof(CGFloat));
	for(int i=0;i<dataLen;i++){ lines[i] = data[i]; }
}

- (void)setLineWidth:(CGFloat)width{ lineWidth = width; }

- (void)setNormalRangeMin:(CGFloat)min max:(CGFloat)max{
	UIColor* color = [[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	[self setNormalRangeMin:min	max:max color:color];
}

- (void)setNormalRangeMin:(CGFloat) min max:(CGFloat)max color:(UIColor*)color{
	normalMin = min;
	normalMax = max;
	normalRangeColor = color;
	showNormalRange = true;
}

- (void)drawRect:(CGRect)rect {
	if (dataLen != 0){
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGFloat	height = rect.size.height;
		CGFloat width = rect.size.width;
		int dataSpan = dataMax - dataMin;
						
		CGPoint addLines[dataLen];
		CGFloat scaleX = (width - 2) / dataLen;
		CGFloat scaleY = (height - 2) / dataSpan;
		CGFloat x = 0.0, y = 0.0;
		
		if (showNormalRange){
			CGContextSetFillColorWithColor(ctx, [normalRangeColor CGColor]);
			CGRect tempRect = CGRectMake(0, (height - 3) - ((normalMax - dataMin) * scaleY),
										 width, (normalMax - normalMin) * scaleY);
			CGContextFillRect(ctx, tempRect);
		}
		
		for (int i=0 ; i<=dataLen ; i++){
			x = (i * scaleX);
			y = (height - 3) - ((lines[i] - dataMin) * scaleY);

			addLines[i] = CGPointMake(x,y);
		}

		CGContextAddLines(ctx, addLines, dataLen + 1);
		CGContextSetStrokeColorWithColor(ctx, [lineColor CGColor]);
		CGContextSetLineWidth(ctx, lineWidth);
		CGContextStrokePath(ctx);
	
		CGRect	endRect = CGRectMake(addLines[dataLen].x - 3, addLines[dataLen].y - 3, 5.0, 5.0);
		CGContextSetFillColorWithColor(ctx, [dotColor CGColor]);
		CGContextFillEllipseInRect(ctx, endRect);

		/*CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, 1.0);
		CGContextStrokeRect(ctx, CGRectMake(0, 0, width, height));
		CGContextMoveToPoint(ctx, 0, (height/2) - 3);
		CGContextAddLineToPoint(ctx, width, (height/2) - 3);*/
	}
}


- (void)dealloc {
	[dotColor dealloc];
	[normalRangeColor dealloc];
	[lineColor dealloc];
    [super dealloc];
}


@end

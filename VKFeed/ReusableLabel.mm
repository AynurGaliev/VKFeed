//
//  ReusableLabel.m
//  AsyncLayout
//
//  Created by Aynur Galiev on 17/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

#import "ReusableLabel.h"
#import <CoreText/CoreText.h>
#import <sys/kdebug_signpost.h>
#include <vector>
#include <numeric>
#import "ReusableLabelCachedLayout.h"

using namespace std;

@interface ReusableLabel()
@property (strong, nonatomic) ReusableLabelCachedLayout *layout;
@end

@implementation ReusableLabel {
    CTFramesetterRef frameSetter;
    CTFrameRef frame;
    CFArrayRef lines;
}

-(void)setText:(NSString *)text cachedLayout:(ReusableLabelCachedLayout *)layout {
    [self setText:text];
    self.layout = layout;
}

-(void)setAttributedText:(NSAttributedString *)attributedText cachedLayout:(ReusableLabelCachedLayout *)layout {
    [self setAttributedText:attributedText];
    self.layout = layout;
}

- (void)drawRect:(CGRect)rect {

    static vector<double> timeStamps;

    double start = CACurrentMediaTime();

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.5f*rect.size.width, 0.5f * rect.size.height) ;
    CGContextRotateCTM(context, M_PI);
    CGContextScaleCTM(context, -1, 1);
    CGContextTranslateCTM(context, -0.5f * rect.size.width, -0.5f * rect.size.height);

    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CFArrayRef lines = self.layout.lines;
    CGPoint *origins = self.layout.origins;

    long linesCount = CFArrayGetCount(lines);
    for (long i=0; i<linesCount; i++) {
        CGContextSetTextPosition(context, origins[i].x, origins[i].y);
        CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, i);
        CTLineDraw(line, context);
    }

    double end = CACurrentMediaTime();
    timeStamps.push_back(end - start);
    double sum = accumulate(timeStamps.begin(), timeStamps.end(), 0.0);
    NSLog(@"Average - %f", accumulate(timeStamps.begin(), timeStamps.end(), 0.0)/timeStamps.size());
    NSLog(@"Sum - %f", sum);
}

@end

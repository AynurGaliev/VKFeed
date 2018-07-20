//
//  ReusableLabelCachedLayout.m
//  AsyncLayout
//
//  Created by Aynur Galiev on 18/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

#import "ReusableLabelCachedLayout.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface ReusableLabelCachedLayout()
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) NSDictionary *attributes;
@property (assign, nonatomic) NSInteger maxLinesCount;
@property (assign, nonatomic) CGFloat constrainedWidth;
@end

@implementation ReusableLabelCachedLayout {
    CFArrayRef lines;
    CGPoint *origins;
    CGSize renderedSize;
    CGImageRef renderedImage;
}

-(instancetype)initWithString:(NSString *)text
                   attributes:(NSDictionary *)attributes
                maxLinesCount:(NSInteger)maxLinesCount
             constrainedWidth:(CGFloat)constrainedWidth {
    self = [super init];
    if(self) {
        self.text = text;
        self.attributes = attributes;
        self.maxLinesCount = maxLinesCount;
        self.constrainedWidth = constrainedWidth;
        [self performCalculations];
    }
    return self;
}

-(void)performCalculations {
    
    CFAttributedStringRef attributedString = CFAttributedStringCreate(
            CFAllocatorGetDefault(),
            (__bridge CFStringRef)self.text,
            (__bridge CFDictionaryRef)self.attributes
    );
    
    CFIndex length = CFAttributedStringGetLength(attributedString);
    CFRange range = CFRangeMake(0, length);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attributedString);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(
           frameSetter,
           range,
           NULL,
           CGSizeMake(self.constrainedWidth, CGFLOAT_MAX),
           NULL
    );
    
    self->renderedSize = CGSizeMake(ceil(size.width), ceil(size.height));
    CGRect rect = CGRectMake(0, 0, self->renderedSize.width, self->renderedSize.height);
    
    CGPathRef framePath = CGPathCreateWithRect(rect, NULL);
    
    CTFrameRef frame = CTFramesetterCreateFrame(
           frameSetter,
           range,
           framePath,
           NULL
    );
    self->lines = CTFrameGetLines(frame);
    long linesCount = CFArrayGetCount(self->lines);
    
    self->origins = (CGPoint *)malloc(sizeof(CGPoint) * linesCount);
    CTFrameGetLineOrigins(frame, CFRangeMake(0, linesCount), self->origins);
}

-(CFArrayRef)lines {
    return self->lines;
}

-(CGPoint *)origins {
    return self->origins;
}

- (CGSize)renderedSize {
    return self->renderedSize;
}

-(CGImageRef)renderedImage {
    return self->renderedImage;
}

- (void)dealloc {
    if(self->origins) {
        free(self->origins);
    }
    if(self->lines) {
        CFRelease(self->lines);
    }
}

@end

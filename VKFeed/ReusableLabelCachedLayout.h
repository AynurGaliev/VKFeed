//
//  ReusableLabelCachedLayout.h
//  AsyncLayout
//
//  Created by Aynur Galiev on 18/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ReusableLabelCachedLayout: NSObject
-(instancetype)initWithString:(NSString *)text
                   attributes:(NSDictionary *)attributes
                maxLinesCount:(NSInteger)maxLinesCount
             constrainedWidth:(CGFloat)constrainedWidth;
-(CFArrayRef)lines;
-(CGSize)renderedSize;
-(CGPoint *)origins;
-(CGImageRef)renderedImage;
@end

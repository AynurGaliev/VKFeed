//
//  ReusableLabel.h
//  AsyncLayout
//
//  Created by Aynur Galiev on 17/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReusableLabelCachedLayout;

@interface ReusableLabel: UILabel
-(void)setText:(NSString *)text cachedLayout:(ReusableLabelCachedLayout *)layout;
-(void)setAttributedText:(NSAttributedString *)attributedText cachedLayout:(ReusableLabelCachedLayout *)layout;
@end

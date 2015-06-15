//
//  SpacingLabel.m
//
//  Created by Cyril Chandelier on 07/06/15.
//  Copyright (c) 2015 Cyril Chandelier. All rights reserved.
//

#import "SpacingLabel.h"

#import <CoreText/CoreText.h>



@interface SpacingLabel ()

// Drawing
@property (nonatomic, strong) UILabel *drawingLabel;

// Fonts
@property (nonatomic, strong) UIFont *firstLineFont;
@property (nonatomic, strong) UIFont *lastLineFont;

@end



@implementation SpacingLabel

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Ensure the view is not clipping bounds
    self.clipsToBounds = NO;
}

- (void)reset
{
    // Find biggest font of both first and last line (could be the same)
    NSArray *lines = [self getLinesArrayOfStringInLabel];
    if ([lines count])
    {
        self.firstLineFont = [self biggestFontOfLine:[lines firstObject]];
        self.lastLineFont = [self biggestFontOfLine:[lines lastObject]];
    }
    else
    {
        self.firstLineFont = nil;
        self.lastLineFont = nil;
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [self invalidateIntrinsicContentSize];
    
    CGRect drawingRect = [self.attributedText boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)
                                                           options:(NSStringDrawingUsesLineFragmentOrigin)
                                                           context:nil];
    
    self.drawingLabel.attributedText = self.attributedText;
    self.drawingLabel.frame = CGRectMake(0, -(self.firstLineFont.ascender - self.firstLineFont.capHeight), CGRectGetWidth(rect), ceil(CGRectGetHeight(drawingRect)));
}

#pragma mark - Layout

- (CGSize)sizeThatFits:(CGSize)size
{
    // Get the size the label should have normally
    CGRect rect = [self.attributedText boundingRectWithSize:size
                                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                    context:nil];
    
    // Basically, the desired size is the default size minus space on top of the first line and space under the last line
    return CGSizeMake(size.width, ceil(rect.size.height) - (self.firstLineFont.ascender - self.firstLineFont.capHeight) + self.lastLineFont.descender);
}

- (CGSize)intrinsicContentSize
{
    CGSize sizeThatFits = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)];
    return CGSizeMake(UIViewNoIntrinsicMetric, sizeThatFits.height);
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

#pragma - Lazy loading

- (UILabel *)drawingLabel
{
    if (!_drawingLabel)
    {
        _drawingLabel = [[UILabel alloc] init];
        _drawingLabel.numberOfLines = self.numberOfLines;
        [self addSubview:_drawingLabel];
    }
    
    return _drawingLabel;
}

#pragma mark - Setters

- (void)setHighlighted:(BOOL)highlighted
{
    // Oups, this don't support highligthed state
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self reset];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self reset];
}

#pragma mark - Utils

- (NSArray *)getLinesArrayOfStringInLabel
{
    NSAttributedString *text = [self attributedText];
    CGRect rect = [self frame];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, CGFLOAT_MAX));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSAttributedString *lineString = [text attributedSubstringFromRange:range];
        [linesArray addObject:lineString];
    }
    
    return (NSArray *)linesArray;
}

- (UIFont *)biggestFontOfLine:(NSAttributedString *)line
{
    __block UIFont *font = nil;
    [line enumerateAttribute:NSFontAttributeName
                     inRange:NSMakeRange(0, line.length)
                     options:0
                  usingBlock:^(UIFont *value, NSRange range, BOOL *stop) {
                      if (value.lineHeight > font.lineHeight)
                      {
                          font = value;
                      }
                  }];
    
    return font;
}

@end
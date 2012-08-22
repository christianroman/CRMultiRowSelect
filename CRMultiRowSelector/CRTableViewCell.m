//
//  CRTableViewCell.m
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import "CRTableViewCell.h"

#define colorWithRGBHex(hex)[UIColor colorWithRed:((float)((hex&0xFF0000)>>16))/255.0 green:((float)((hex&0xFF00)>> 8))/255.0 blue:((float)(hex&0xFF))/255.0 alpha:1.0]
#define clearColorWithRGBHex(hex)[UIColor colorWithRed:MIN((((int)(hex>>16)&0xFF)/255.0)+0.1,1.0)green:MIN((((int)(hex>>8)&0xFF)/255.0)+0.1,1.0)blue:MIN((((int)(hex)&0xFF)/255.0)+0.1,1.0)alpha:1.0]

#define kUnselectedRect         CGRectMake(13, 10, 23, 23)
#define kCircleRect             CGRectMake(3.5, 2.5, 22, 22)
#define kCircleOverlayRect      CGRectMake(2.5, 12.5, 26, 22)

#define kStrokeWidth            2.0f

#define kShadowRadius           4.0f
#define kShadowOffset           CGSizeMake(0, 2.0f)
#define kShadowColor            [UIColor colorWithWhite:0.0f alpha:0.7f]
#define kMarkShadowColor        [UIColor colorWithWhite:0.0f alpha:0.5f]
#define kBlueColor              0x236ed8
#define kGreenColor             0x179714
#define kRedColor               0xa4091c
#define kMarkColor              0xff8a00
#define kMarkImageSize          CGSizeMake(30, 30)
#define kMarkBase               CGPointMake(9, 13.5)
#define kMarkDegrees            70.0f
#define kMarkWidth              3.0f
#define kMarkHeight             6.0f
#define kMarkShadowOffset       CGSizeMake(0, -1.0f)
#define kMarkDrawPoint          CGPointMake(20.0f, 9.5f)

#define kColumnPosition         50.0f
#define kCellImageViewTag		1000
#define kCellLabelTag			1001
#define kMarkCell               60
#define kSelectionIndicatorTag  2000

#define kLabelIndentedRect      CGRectMake(60.0, 12.0, 290.0, 20.0)
#define kLabelRect              CGRectMake(15.0, 12.0, 275.0, 20.0)
#define kImageRect              CGRectMake(10.0, 8.0, 30.0, 30.0)

@implementation CRTableViewCell

@synthesize isSelected = _isSelected;
@synthesize textLabel = label;
@synthesize imageView = imageView;
@synthesize renderedMark = _renderedMark;

- (void)drawRect:(CGRect)rect
{    
    _isSelected = NO;
    
    UIBezierPath *unselectedCircle = [UIBezierPath bezierPathWithOvalInRect:kUnselectedRect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /* Unselected circle */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, unselectedCircle.CGPath);
        CGContextSetLineWidth(ctx, kStrokeWidth);
        CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
        CGContextSetRGBStrokeColor(ctx, 229/255.0f, 229/255.0f, 229/255.0f, 1.0f);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
    CGContextRestoreGState(ctx);
    
    /* Column separator */
    CGContextSetRGBStrokeColor(ctx, 224/255.0f, 224/255.0f, 224/255.0f, 1.0f);
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextMoveToPoint(ctx, kColumnPosition, .0f);
    CGContextAddLineToPoint(ctx, kColumnPosition, self.bounds.size.height);
    CGContextSetShouldAntialias(ctx, NO);
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (UIImage *)renderMark
{
    if(_renderedMark)
        return _renderedMark;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(kMarkImageSize, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(kMarkImageSize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
    
    /* Background */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, markCircle.CGPath);
        CGContextSetFillColorWithColor(ctx, clearColorWithRGBHex(kMarkColor).CGColor);
        CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
        CGContextDrawPath(ctx, kCGPathFill);
    }
    CGContextRestoreGState(ctx);
    
    /* Overlay */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, markCircle.CGPath);
        CGContextClip(ctx);
        CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
        CGContextSetFillColorWithColor(ctx, colorWithRGBHex(kMarkColor).CGColor);
        CGContextDrawPath(ctx, kCGPathFill);
    }
    CGContextRestoreGState(ctx);
    
    /* Stroke */
    CGContextSaveGState(ctx);
    {
        CGContextAddPath(ctx, markCircle.CGPath);
        CGContextSetLineWidth(ctx, kStrokeWidth);
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    CGContextRestoreGState(ctx);
    
    /* Mark */
    CGContextSaveGState(ctx);
    {
        CGContextSetShadowWithColor(ctx, kMarkShadowOffset, 1.0, kMarkShadowColor.CGColor );
        CGContextMoveToPoint(ctx, kMarkBase.x, kMarkBase.y);
        CGContextAddLineToPoint(ctx, kMarkBase.x + kMarkHeight * sin(kMarkDegrees), kMarkBase.y + kMarkHeight * cos(kMarkDegrees));
        CGContextAddLineToPoint(ctx, kMarkDrawPoint.x, kMarkDrawPoint.y);
        CGContextSetLineWidth(ctx, kMarkWidth);
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextStrokePath(ctx);
    }
    
    UIImage *selectedMark = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return selectedMark;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(kMarkCell, 0, self.frame.size.width - kMarkCell, self.frame.size.height)];
        label.textColor = [UIColor blackColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:label];
        
        imageView = [UIImageView new];
        imageView.frame = kImageRect;
		[self.contentView addSubview:imageView];
        
        _renderedMark = [self renderMark];
    }
    return self;
}

#pragma mark - Properties
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.imageView.image = (isSelected) ? _renderedMark : nil;
}

@end

//
//  CRTableViewCell.m
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import "CRTableViewCell.h"

@implementation CRTableViewCell

@synthesize isSelected = _isSelected;
@synthesize textLabel = label;
@synthesize imageView = imageView;

- (void)drawRect:(CGRect)rect
{    
    _isSelected = NO;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(currentContext, 224/255.0f, 224/255.0f, 224/255.0f, 1.0f);
    CGContextSetLineWidth(currentContext, 1.0f);
    CGContextMoveToPoint(currentContext, kMarkPosition, .0f);
    CGContextAddLineToPoint(currentContext, kMarkPosition, self.bounds.size.height);
    CGContextSetShouldAntialias(currentContext, NO);
    CGContextStrokePath(currentContext);
    
    [super drawRect:rect];
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
        
		imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kUnselected]];
        imageView.frame = kImageRect;
		[self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Properties
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.imageView.image = (isSelected) ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d", kSelected, redColor]] : [UIImage imageNamed: kUnselected];
}

@end

//
//  CRTableViewCell.m
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import "CRTableViewCell.h"

@implementation CRTableViewCell

@synthesize isSelected;

- (void)drawRect:(CGRect)rect
{    
    isSelected = NO;
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
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

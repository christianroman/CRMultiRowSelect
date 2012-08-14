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

- (void)addColumn:(CGFloat)position {
    if(!columns)
        columns = [[NSMutableArray alloc] init];
    [columns addObject:[NSNumber numberWithFloat:position]];
}

- (void)drawRect:(CGRect)rect
{
    isSelected = NO;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, .5, .5, .5, 1.0);
    CGContextSetLineWidth(ctx, .25);
    
    for(NSNumber *column in columns){
        CGFloat f = [column floatValue];
        CGContextMoveToPoint(ctx, f, .0);
        CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
    }
    
    CGContextStrokePath(ctx);
    
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

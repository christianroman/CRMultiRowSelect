//
//  CRTableViewCell.h
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRTableViewCell : UITableViewCell
{
    BOOL isSelected;
    NSMutableArray *columns;
}

@property (nonatomic, assign) BOOL isSelected;
- (void)addColumn:(CGFloat) position;

@end

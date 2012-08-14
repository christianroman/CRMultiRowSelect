//
//  CRTableViewController.h
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellImageViewTag		1000
#define kCellLabelTag			1001
#define kMarkCell               60
#define kSelectionIndicatorTag  2000

#define kLabelIndentedRect	CGRectMake(60.0, 12.0, 290.0, 20.0)
#define kLabelRect			CGRectMake(15.0, 12.0, 275.0, 20.0)

@interface CRTableViewController : UITableViewController
{
    NSArray *dataSource;
}

@property (nonatomic, retain) NSArray *dataSource;

@end

//
//  CRTableViewController.h
//  CRMultiRowSelector
//
//  Created by Christian Roman on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRTableViewController : UITableViewController
{
    NSArray *dataSource;
    NSMutableArray *selectedMarks;
}

@property (nonatomic) NSArray *dataSource;

@end
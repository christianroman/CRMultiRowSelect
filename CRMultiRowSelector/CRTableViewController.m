//
//  CRTableViewController.m
//  CRMultiRowSelector
//
//  Created by Christian Roman Mendoza on 6/17/12.
//  Copyright (c) 2012 chroman. All rights reserved.
//

#import "CRTableViewController.h"
#import "CRTableViewCell.h"

@interface CRTableViewController ()

@end

@implementation CRTableViewController

@synthesize dataSource;

#pragma mark - Lifecycle
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.title = @"CRMultiRowSelector";
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                        style:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        dataSource = [[NSArray alloc] initWithObjects:
                      @"Lorem ipsum dolor",
                      @"consectetur adipisicing",
                      @"Sed do eiusmod tempor", 
                      @"incididunt ut labore",
                      @"et dolore magna aliqua",
                      @"Ut enim ad minim",
                      @"quis nostrud exercitation",
                      @"ullamco laboris nisi ut",
                      @"Duis aute irure dolor in reprehenderit",
                      @"in voluptate velit esse cillum",
                      @"dolore eu fugiat nulla pariatur",
                      nil];
        
        selectedMarks = [NSMutableArray new];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Methods
- (void)done:(id)sender
{
    NSLog(@"%@", selectedMarks);
}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    
    CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
    }
    
	UILabel *label = (UILabel *)[cell.contentView viewWithTag:kCellLabelTag];
	label.text = [dataSource objectAtIndex:[indexPath row]];
	
	UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:kCellImageViewTag];
	imageView.image = (cell.isSelected) ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d", kSelected, redColor]] : [UIImage imageNamed: kUnselected];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRTableViewCell *cell = (CRTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
        return;
    
    cell.isSelected = !cell.isSelected;
    
    if(cell.isSelected)
        [selectedMarks addObject:[dataSource objectAtIndex:[indexPath row]]];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData];
}

@end

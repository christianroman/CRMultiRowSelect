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
        [rightButton release];
        
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

- (void)dealloc
{
    [dataSource release];
    [selectedMarks release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

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
    NSString *CRTableViewCellIdentifier = [NSString stringWithFormat:@"CRTableViewCell %i", indexPath.row];
    
    CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier] autorelease];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMarkCell, 0, self.view.superview.frame.size.width - kMarkCell, cell.frame.size.height)];
		label.tag = kCellLabelTag;
        label.textColor = [UIColor blackColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:label];
		[label release];
        
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @Stringify(kUnselected)]];
		imageView.frame = kImageRect;
        imageView.tag = kSelectionIndicatorTag;
		[cell.contentView addSubview:imageView];
		imageView.tag = kCellImageViewTag;
		[imageView release];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
	UILabel *label = (UILabel *)[cell.contentView viewWithTag:kCellLabelTag];
	label.text = [dataSource objectAtIndex:[indexPath row]];
	
	UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:kCellImageViewTag];
	imageView.image = (cell.isSelected) ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d", @Stringify(kSelected), redColor]] : [UIImage imageNamed: @Stringify(kUnselected)];
    
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

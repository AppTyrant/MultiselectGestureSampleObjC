//
//  TableViewController.m
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
//

#import "TableViewController.h"
#import "FillerModel.h"

@interface TableViewController ()

@property (nonatomic,strong) NSArray<FillerModel*>*items;

@end

@implementation TableViewController

-(NSArray*)items
{
    if (_items == nil)
    {
        _items = [FillerModel generateFillerItemsForCount:100];
    }
    return _items;
}
 
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (!editing)
    {
        self.title = @"";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    static NSString *const CellId = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row].title;
    cell.detailTextLabel.text = self.items[indexPath.row].descriptionText;
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

#pragma mark - Multiple selection methods.
-(BOOL)tableView:(UITableView*)tableView shouldBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    return YES;
}

/// - Tag: table-view-did-begin-multi-select
-(void)tableView:(UITableView*)tableView didBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    // Replace the Edit button with Done, and put the
    // table view into editing mode.
    [self setEditing:YES animated:YES];
}

/// - Tag: table-view-did-end-multi-select
-(void)tableViewDidEndMultipleSelectionInteraction:(UITableView*)tableView
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.isEditing)
    {
        self.title = [NSString stringWithFormat:@"%lu selected",tableView.indexPathsForSelectedRows.count];
    }
}

-(void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.isEditing && tableView.indexPathsForSelectedRows.count > 0)
    {
        self.title = [NSString stringWithFormat:@"%lu selected",tableView.indexPathsForSelectedRows.count];
    }
    else
    {
        self.title = @"";
    }
}

@end

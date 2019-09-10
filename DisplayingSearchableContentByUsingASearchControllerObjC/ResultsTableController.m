//
//  ResultsTableControllerTableViewController.m
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "ResultsTableController.h"

@interface ResultsTableController ()

@end

@implementation ResultsTableController

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredProducts.count;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BaseTableViewController.cellIdentifier
                                                            forIndexPath:indexPath];
    Product *product = [self.filteredProducts objectAtIndex:indexPath.row];
    [self configureCell:cell forProduct:product];
    return cell;
}

@end

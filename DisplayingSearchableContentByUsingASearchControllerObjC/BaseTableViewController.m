//
//  BaseTableTableViewController.m
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@property (nonatomic,strong) NSNumberFormatter *numberFormatter;

@end

@implementation BaseTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"TableCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:BaseTableViewController.cellIdentifier];
}

#pragma mark - Configuration
-(void)configureCell:(UITableViewCell*)cell forProduct:(Product*)product
{
    cell.textLabel.text = product.title;
    
    /** Build the price and year string.
     Use NSNumberFormatter to get the currency format out of this NSNumber (product.introPrice).
     */
    NSString *priceString = [self.numberFormatter stringFromNumber:@(product.introPrice)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %li",priceString,product.yearIntroduced];
}

-(NSNumberFormatter*)numberFormatter
{
    if (_numberFormatter == nil)
    {
        _numberFormatter = [[NSNumberFormatter alloc]init];
        _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        _numberFormatter.formatterBehavior = NSNumberFormatterBehaviorDefault;
    }
    return _numberFormatter;
}

+(NSString*)cellIdentifier
{
    static NSString *CellID = @"cellID";
    return CellID;
}

@end

//
//  BaseTableTableViewController.h
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface BaseTableViewController : UITableViewController

-(void)configureCell:(nonnull UITableViewCell*)cell forProduct:(nonnull Product*)product;

@property (nonnull,nonatomic,readonly,class) NSString *cellIdentifier;

@end



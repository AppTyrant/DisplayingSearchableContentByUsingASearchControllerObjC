//
//  MainTableViewController.h
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewController : BaseTableViewController

@property (nonatomic,strong,readonly) NSArray <Product*>*products;

@end

NS_ASSUME_NONNULL_END

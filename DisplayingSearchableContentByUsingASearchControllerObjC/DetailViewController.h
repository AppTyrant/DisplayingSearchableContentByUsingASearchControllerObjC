//
//  DetailViewController.h
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailViewController : UIViewController

+(nonnull DetailViewController*)detailViewControllerForProduct:(nonnull Product*)product;

@property (nonnull,nonatomic,strong) Product *product;

@end



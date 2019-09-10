//
//  DetailViewController.m
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic,weak) UILabel *yearLabel;
@property (nonatomic,weak) UILabel *priceLabel;

@end

@implementation DetailViewController

+(DetailViewController*)detailViewControllerForProduct:(Product*)product
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.product = product;
    return detailVC;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    self.title = self.product.title;
    self.yearLabel.text = [NSString stringWithFormat:@"%lu",self.product.yearIntroduced];
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil)
    {
       numberFormatter = [[NSNumberFormatter alloc]init];
       numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
       numberFormatter.formatterBehavior = NSNumberFormatterBehaviorDefault;
    }
    NSString *priceString = [numberFormatter stringFromNumber:@(self.product.introPrice)];
    self.priceLabel.text = priceString;
}

#pragma mark - UIStateRestoration
-(void)encodeRestorableStateWithCoder:(NSCoder*)coder
{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.product forKey:@"restoreProductKey"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder*)coder
{
    [super decodeRestorableStateWithCoder:coder];
    self.product = [coder decodeObjectForKey:@"restoreProductKey"];
}

@end

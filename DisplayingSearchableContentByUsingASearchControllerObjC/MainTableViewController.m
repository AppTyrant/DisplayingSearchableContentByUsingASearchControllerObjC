//
//  MainTableViewController.m
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "MainTableViewController.h"
#import "ResultsTableController.h"
#import "DetailViewController.h"

@interface MainTableViewController () <UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    BOOL _restoredStateWasActive;
    BOOL _restoredStateWasFirstResponder;
}

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) ResultsTableController *resultsTableController;

@end

@implementation MainTableViewController

-(void)_doSetUpOnInit
{
    NSArray *products = @[[[Product alloc]initWithTitle:@"Ginger" yearIntroduced:2007 introPrice:49.98],
                          [[Product alloc]initWithTitle:@"Gladiolus" yearIntroduced:2001 introPrice:51.99],
                          [[Product alloc]initWithTitle:@"Orchid" yearIntroduced:2007 introPrice:16.99],
                          [[Product alloc]initWithTitle:@"Poinsettia" yearIntroduced:2010 introPrice:31.99],
                          [[Product alloc]initWithTitle:@"RedRose" yearIntroduced:2010 introPrice:24.99],
                          [[Product alloc]initWithTitle:@"WhiteRose" yearIntroduced:2012 introPrice:24.99],
                          [[Product alloc]initWithTitle:@"Tulip" yearIntroduced:1997 introPrice:39.99],
                          [[Product alloc]initWithTitle:@"Carnation" yearIntroduced:2006 introPrice:23.99],
                          [[Product alloc]initWithTitle:@"Sunflower" yearIntroduced:2008 introPrice:25.00],
                          [[Product alloc]initWithTitle:@"Gardenia" yearIntroduced:2006 introPrice:25.00]];
    _products = products;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _doSetUpOnInit];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self _doSetUpOnInit];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self _doSetUpOnInit];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.resultsTableController = [[ResultsTableController alloc]initWithStyle:UITableViewStylePlain];
    self.resultsTableController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.navigationItem.searchController = self.searchController;
    // Make the search bar always visible.
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES; // The default is true.
    self.searchController.searchBar.delegate = self; // Monitor when the search button is tapped.
    /** Search presents a view controller by applying normal view controller presentation semantics.
     This means that the presentation moves up the view controller hierarchy until it finds the root
     view controller or one that defines a presentation context.
     */
    
    /** Specify that this view controller determines how the search controller is presented.
     The search controller should be presented modally and match the physical size of this view controller.
     */
    self.definesPresentationContext = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Restore the searchController's active state.
    if (_restoredStateWasActive)
    {
        self.searchController.active = YES;
        _restoredStateWasActive = NO;
        
        if (_restoredStateWasFirstResponder)
        {
            [self.searchController.searchBar becomeFirstResponder];
            _restoredStateWasFirstResponder = NO;
        }
    }
}


#pragma mark - UITableViewDelegate/Datasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *selectedProduct;
    
    // Check to see which table view cell was selected.
    if (tableView == self.tableView)
    {
        selectedProduct = self.products[indexPath.row];
    }
    else
    {
        selectedProduct = self.resultsTableController.filteredProducts[indexPath.row];
    }
    
    // Set up the detail view controller to show.
    DetailViewController *detailViewController = [DetailViewController detailViewControllerForProduct:selectedProduct];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BaseTableViewController.cellIdentifier
                                                            forIndexPath:indexPath];
    
    Product *product = self.products[indexPath.row];
    [self configureCell:cell forProduct:product];
    return cell;
}


#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchControllerDelegate
// Use these delegate functions for additional control over the search controller.
-(void)presentSearchController:(UISearchController*)searchController
{
    NSLog(@"UISearchControllerDelegate invoked method: %@.",NSStringFromSelector(_cmd));
}

-(void)willPresentSearchController:(UISearchController*)searchController
{
     NSLog(@"UISearchControllerDelegate invoked method: %@.",NSStringFromSelector(_cmd));
}

-(void)didPresentSearchController:(UISearchController*)searchController
{
    NSLog(@"UISearchControllerDelegate invoked method: %@.",NSStringFromSelector(_cmd));
}

-(void)willDismissSearchController:(UISearchController*)searchController
{
    NSLog(@"UISearchControllerDelegate invoked method: %@.",NSStringFromSelector(_cmd));
}

-(void)didDismissSearchController:(UISearchController*)searchController
{
   NSLog(@"UISearchControllerDelegate invoked method: %@.",NSStringFromSelector(_cmd));
}

#pragma mark - UISearchResultsUpdating
-(NSCompoundPredicate*)findMatchesForSearchString:(NSString*)searchString
{
    /** Each searchString creates an OR predicate for: name, yearIntroduced, introPrice.
     Example if searchItems contains "Gladiolus 51.99 2001":
     name CONTAINS[c] "gladiolus"
     name CONTAINS[c] "gladiolus", yearIntroduced ==[c] 2001, introPrice ==[c] 51.99
     name CONTAINS[c] "ginger", yearIntroduced ==[c] 2007, introPrice ==[c] 49.98
     */
    //[NSPredicate]()
    NSMutableArray<NSPredicate*>*searchItemsPredicate = [NSMutableArray array];
    
    /** Below we use NSExpression represent expressions in our predicates.
     NSPredicate is made up of smaller, atomic parts:
     two NSExpressions (a left-hand value and a right-hand value).
     */
    
    // Name field matching.
    NSExpression *titleExpression = [NSExpression expressionForKeyPath:NSStringFromSelector(@selector(title))];
    NSExpression *searchStringExpression = [NSExpression expressionForConstantValue:searchString];
    
    NSComparisonPredicate *titleSearchComparisonPredicate = [NSComparisonPredicate predicateWithLeftExpression:titleExpression
                                                                                               rightExpression:searchStringExpression
                                                                                                      modifier:NSDirectPredicateModifier
                                                                                                          type:NSContainsPredicateOperatorType
                                                                                                       options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
   
    
    [searchItemsPredicate addObject:titleSearchComparisonPredicate];
    
    static NSNumberFormatter *NumberFormatter = nil;
    if (NumberFormatter == nil)
    {
        NumberFormatter = [[NSNumberFormatter alloc]init];
        NumberFormatter.numberStyle = NSNumberFormatterNoStyle;
        NumberFormatter.formatterBehavior = NSNumberFormatterBehaviorDefault;
    }
    
    NSNumber *targetNumber = [NumberFormatter numberFromString:searchString];
    if (targetNumber != nil)
    {
        // Use `targetNumberExpression` in both the following predicates.
        NSExpression *targetNumberExpression = [NSExpression expressionForConstantValue:targetNumber];
        
        // The `yearIntroduced` field matching.
        NSExpression *yearIntroducedExpression = [NSExpression expressionForKeyPath:NSStringFromSelector(@selector(yearIntroduced))];
        
        NSComparisonPredicate *yearIntroducedPredicate = [NSComparisonPredicate predicateWithLeftExpression:yearIntroducedExpression rightExpression:targetNumberExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
       
        [searchItemsPredicate addObject:yearIntroducedPredicate];
        
        // The `price` field matching.
        NSExpression *lhs = [NSExpression expressionForKeyPath:NSStringFromSelector(@selector(introPrice))];
        
        NSComparisonPredicate *finalPredicate = [NSComparisonPredicate predicateWithLeftExpression:lhs rightExpression:targetNumberExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
        
        [searchItemsPredicate addObject:finalPredicate];
    }
    
    NSCompoundPredicate *orMatchPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
    return orMatchPredicate;
}

-(void)updateSearchResultsForSearchController:(UISearchController*)searchController
{
    // Update the filtered array based on the search text.
    NSArray *searchResults = self.products;
    
    // Strip out all the leading and trailing spaces.
    NSCharacterSet *whitespaceCharacterSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *strippedString = [searchController.searchBar.text stringByTrimmingCharactersInSet:whitespaceCharacterSet];
    
    NSArray *searchItems = [strippedString componentsSeparatedByString:@" "];
    
    // Build all the "AND" expressions for each value in searchString.
    NSMutableArray<NSCompoundPredicate*>*andMatchPredicates = [NSMutableArray arrayWithCapacity:searchItems.count];
    for (NSString *aSearch in searchItems)
    {
       NSCompoundPredicate *pred = [self findMatchesForSearchString:aSearch];
       [andMatchPredicates addObject:pred];
    }
    
    // Match up the fields of the Product object.
    NSCompoundPredicate *finalCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    
    NSArray *filteredResults = [searchResults filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject,
                                                                                     NSDictionary<NSString *,id> * _Nullable bindings)
    {
        return [finalCompoundPredicate evaluateWithObject:evaluatedObject];
    }]];
    
    // Apply the filtered results to the search results table.
    self.resultsTableController.filteredProducts = filteredResults;
    [self.resultsTableController.tableView reloadData];
}

#pragma mark - UIStateRestoration
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
    
    // Encode the view state so it can be restored later.
    
    // Encode the title.
    [coder encodeObject:self.navigationItem.title forKey:@"viewControllerTitle"];
    
    // Encode the search controller's active state.
    [coder encodeBool:self.searchController.isActive forKey:@"searchControllerIsActive"];
    
    // Encode the first responser status.
    [coder encodeBool:self.searchController.searchBar.isFirstResponder forKey:@"searchBarIsFirstResponder"];
    
    // Encode the search bar text.
    [coder encodeObject:self.searchController.searchBar.text forKey:@"searchBarText"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder*)coder
{
    [super decodeRestorableStateWithCoder:coder];
    NSString *decodedTitle = [coder decodeObjectOfClass:[NSString class] forKey:@"viewControllerTitle"];
    if (decodedTitle != nil)
    {
        self.navigationItem.title = decodedTitle;
    }
    
    /** Restore the active state:
     We can't make the searchController active here since it's not part of the view
     hierarchy yet, instead we do it in viewWillAppear.
     */
    BOOL wasActive = [coder decodeBoolForKey:@"searchControllerIsActive"];
    _restoredStateWasActive = wasActive;
    
    /** Restore the first responder status:
     Like above, we can't make the searchController first responder here since it's not part of the view
     hierarchy yet, instead we do it in viewWillAppear.
     */
    BOOL wasFirstResponder = [coder decodeBoolForKey:@"searchBarIsFirstResponder"];
    _restoredStateWasFirstResponder = wasFirstResponder;
    
    NSString *searchBarText = [coder decodeObjectOfClass:[NSString class] forKey:@"searchBarText"];
    if (searchBarText != nil)
    {
        self.searchController.searchBar.text = searchBarText;
    }
}
    


@end

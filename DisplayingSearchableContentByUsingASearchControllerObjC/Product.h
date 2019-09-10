//
//  Product.h
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSSecureCoding>

-(nonnull instancetype)initWithTitle:(nonnull NSString*)title
                      yearIntroduced:(NSInteger)yearIntroduced
                          introPrice:(double)introPrice NS_DESIGNATED_INITIALIZER;

-(nonnull instancetype)initWithCoder:(nonnull NSCoder*)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonnull,nonatomic,strong,readonly) NSString *title;
@property (nonatomic,readonly) NSInteger yearIntroduced;
@property (nonatomic,readonly) double introPrice;

-(nonnull instancetype)init NS_UNAVAILABLE;

@end



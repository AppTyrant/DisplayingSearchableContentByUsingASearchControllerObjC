//
//  Product.h
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSSecureCoding>

-(instancetype)initWithTitle:(NSString*)title
              yearIntroduced:(NSInteger)yearIntroduced
                  introPrice:(double)introPrice NS_DESIGNATED_INITIALIZER;

-(instancetype)initWithCoder:(NSCoder*)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic,strong) NSString *title;
@property (nonatomic) NSInteger yearIntroduced;
@property (nonatomic) double introPrice;

-(instancetype)init NS_UNAVAILABLE;

@end



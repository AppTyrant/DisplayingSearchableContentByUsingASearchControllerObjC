//
//  Product.m
//  DisplayingSearchableContentByUsingASearchControllerObjC
//
//  Created by ANTHONY CRUZ on 9/10/19.
//  Copyright © 2019 Writes for All. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithTitle:(NSString*)title
              yearIntroduced:(NSInteger)yearIntroduced
                  introPrice:(double)introPrice;
{
    self = [super init];
    if (self)
    {
        _title = title;
        _yearIntroduced = yearIntroduced;
        _introPrice = introPrice;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self)
    {
        _title = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"nameKey"];
        _yearIntroduced = [aDecoder decodeIntegerForKey:@"yearKey"];
        _introPrice = [aDecoder decodeDoubleForKey:@"priceKey"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:self.title forKey:@"nameKey"];
    [aCoder encodeInteger:self.yearIntroduced forKey:@"yearKey"];
    [aCoder encodeDouble:self.introPrice forKey:@"priceKey"];
}

+(BOOL)supportsSecureCoding
{
    return YES;
}

@end

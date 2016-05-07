//
//  LPResult.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPResult : NSManagedObject

- (float)evaluateResult;
+ (NSArray *)getAllResults:(NSManagedObjectContext *)context;
+ (LPResult *)newResult:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "LPResult+CoreDataProperties.h"

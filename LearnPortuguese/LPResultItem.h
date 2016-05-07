//
//  LPResultItem.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LPResult;

NS_ASSUME_NONNULL_BEGIN

@interface LPResultItem : NSManagedObject

+ (LPResultItem *)newItem:(NSManagedObjectContext *)context;
+ (NSArray *)getAllItemsForResult:(LPResult *)result atContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "LPResultItem+CoreDataProperties.h"

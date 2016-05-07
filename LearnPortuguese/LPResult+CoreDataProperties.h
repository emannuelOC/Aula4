//
//  LPResult+CoreDataProperties.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LPResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface LPResult (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *startDate;
@property (nullable, nonatomic, retain) NSDate *finishDate;
@property (nullable, nonatomic, retain) NSNumber *generalResult;
@property (nullable, nonatomic, retain) NSString *exerciseName;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *resultItems;

@end

@interface LPResult (CoreDataGeneratedAccessors)

- (void)addResultItemsObject:(NSManagedObject *)value;
- (void)removeResultItemsObject:(NSManagedObject *)value;
- (void)addResultItems:(NSSet<NSManagedObject *> *)values;
- (void)removeResultItems:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END

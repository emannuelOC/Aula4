//
//  LPResultItem+CoreDataProperties.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LPResultItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LPResultItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *givenAnswer;
@property (nullable, nonatomic, retain) NSString *rightAnswer;
@property (nullable, nonatomic, retain) NSNumber *evaluation;
@property (nullable, nonatomic, retain) LPResult *result;

@end

NS_ASSUME_NONNULL_END

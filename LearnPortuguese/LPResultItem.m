//
//  LPResultItem.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPResultItem.h"
#import "LPResult.h"

@implementation LPResultItem

+ (LPResultItem *)newItem:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LPResultItem" inManagedObjectContext:context];
    LPResultItem *item = [[LPResultItem alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    return item;
}

+ (NSArray *)getAllItemsForResult:(LPResult *)result atContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LPResultItem"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"result = %@", result];
    request.predicate = predicate;
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!error) {
        return results;
    }
    return nil;
}

@end

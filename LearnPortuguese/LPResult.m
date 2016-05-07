//
//  LPResult.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPResult.h"
#import "LPResultItem.h"

@implementation LPResult

+ (NSArray *)getAllResults:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LPResult"];
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!error) {
        return results;
    }
    return nil;
}

+ (LPResult *)newResult:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LPResult" inManagedObjectContext:context];
    LPResult *result = [[LPResult alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    return result;
}

- (float)evaluateResult {
    float total = 0.0;
    for (LPResultItem *item in self.resultItems) {
        total += item.evaluation.floatValue;
    }
    total = total / self.resultItems.count;
    self.generalResult = [NSNumber numberWithFloat:total];
    return total;
}

@end

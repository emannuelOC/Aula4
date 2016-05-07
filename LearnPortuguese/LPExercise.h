//
//  LPExercise.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LPExerciseItem;

@interface LPExercise : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray<LPExerciseItem *> *items;
@property (strong, nonatomic) LPExerciseItem *currentItem;

+ (LPExercise *)exerciseWithDictionary:(NSDictionary *)dictionary;
- (void)stepForward;
@end

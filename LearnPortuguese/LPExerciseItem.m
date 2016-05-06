//
//  LPExerciseItem.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPExerciseItem.h"

@implementation LPExerciseItem

- (LPExerciseItem *)initWithQuestion:(NSString *)question alternatives:(NSArray *)alternatives andRightAnswer:(NSString *)rightAnswer {
    self = [super init];
    if (!self) {
        return nil;
    }
    _question     = question;
    _alternatives = alternatives;
    _rightAnswer  = rightAnswer;
    return self;
}

+ (LPExerciseItem *)itemWithDictionary:(NSDictionary *)dictionary {
    NSString *question     = dictionary[@"question"];
    NSArray  *alternatives = dictionary[@"alternatives"];
    NSString *rightAnswer  = dictionary[@"rightAnswer"];
    if (!question || !alternatives || !rightAnswer) {
        return nil;
    }
    return [[LPExerciseItem alloc] initWithQuestion:question alternatives:alternatives andRightAnswer:rightAnswer];
}

@end

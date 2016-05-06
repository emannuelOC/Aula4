//
//  LPExerciseItem.h
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPExerciseItem : NSObject
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSArray  *alternatives;
@property (strong, nonatomic) NSString *rightAnswer;

+ (LPExerciseItem *)itemWithDictionary:(NSDictionary *)dictionary;
@end

//
//  LPExercise.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPExercise.h"
#import "LPExerciseItem.h"

@implementation LPExercise {
    int _index;
}

- (LPExercise *)initWithName:(NSString *)name andItems:(NSArray *)items {
    self = [super init];
    if (!self) {
        return nil;
    }
    _name  = name;
    _items = items;
    if (_items.count > 0) {
        _index = 0;
        _currentItem = _items[_index];
    }
    return self;
}

+ (LPExercise *)exerciseWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSArray  *items = dictionary[@"questions"];
    NSMutableArray *newItems = [[NSMutableArray alloc] init];
    for (NSDictionary *itemDictionary in items) {
        LPExerciseItem *item = [LPExerciseItem itemWithDictionary:itemDictionary];
        if (item) {
            [newItems addObject:item];
        }
    }
    if (!name) {
        return nil;
    }
    return [[LPExercise alloc] initWithName:name andItems:newItems];
}

- (void)stepForward {
    _index++;
    if (_index >= _items.count) {
        _currentItem = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LPExerciseIsOutOfItems" object:self];
    } else {
        _currentItem = _items[_index];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LPExerciseItemDidChange"
                                                            object:self
                                                          userInfo:@{@"item":_currentItem}];
    }
}

@end

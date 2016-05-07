//
//  LPExerciseViewController.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPExerciseViewController.h"
#import "LPResultItem.h"
#import "AppDelegate.h"
#import "LPResult.h"

@interface LPExerciseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *option1Button;
@property (weak, nonatomic) IBOutlet UIButton *option2Button;
@property (weak, nonatomic) IBOutlet UIButton *option3Button;
@property (weak, nonatomic) IBOutlet UIButton *option4Button;
/***/
@property (strong, nonatomic) LPResult *result;
@property (strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation LPExerciseViewController

#pragma mark - ViewController life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateItem:nil];
    _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    _result = [LPResult newResult:_context];
    _result.startDate = [NSDate date];
    _result.exerciseName = _exercise.name;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateItem:) name:@"LPExerciseItemDidChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishExercise) name:@"LPExerciseIsOutOfItems" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)stopExercise:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)evaluateAnswer:(UIButton *)sender {
    LPResultItem *item = [LPResultItem newItem:_context];
    item.rightAnswer = _exercise.currentItem.rightAnswer;
    item.givenAnswer = sender.titleLabel.text;
    item.evaluation = [NSNumber numberWithBool:[item.rightAnswer isEqualToString:item.givenAnswer]];
    [_result addResultItemsObject:item];
    if ([sender.titleLabel.text isEqualToString:_exercise.currentItem.rightAnswer]) {
        sender.backgroundColor = [UIColor greenColor];
    } else {
        sender.backgroundColor = [UIColor redColor];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.questionLabel.transform = CGAffineTransformMakeTranslation(-400, 0);
    } completion:^(BOOL finished) {
        self.questionLabel.transform = CGAffineTransformMakeTranslation(400, 0);
        sender.backgroundColor = [UIColor whiteColor];
        [self.exercise stepForward];
    }];
}

- (void)updateItem:(NSNotification *)notification {
    LPExerciseItem *item = _exercise.currentItem;
    _questionLabel.text = item.question;
    NSArray *alternatives = _exercise.currentItem.alternatives;
    if (alternatives.count == 4) {
        [_option1Button setTitle:alternatives[0] forState:UIControlStateNormal];
        [_option2Button setTitle:alternatives[1] forState:UIControlStateNormal];
        [_option3Button setTitle:alternatives[2] forState:UIControlStateNormal];
        [_option4Button setTitle:alternatives[3] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.questionLabel.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)finishExercise {
    [_result evaluateResult];
    _result.finishDate = [NSDate date];
    NSError *error;
    [_context save:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LPDidUpdateResults" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

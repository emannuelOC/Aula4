//
//  ViewController.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "LPExerciseViewController.h"
#import "ViewController.h"
#import "LPExercise.h"

@interface ViewController ()
@property NSArray *exercises;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _exercises = [[NSArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:@"http://lana.mybluemix.net/api/exercises"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *localError;
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
            if (results) {
                NSArray *exercises = results[@"results"];
                NSMutableArray *newExercises = [[NSMutableArray alloc] init];
                for (NSDictionary *exerciseDictionary in exercises) {
                    LPExercise *exercise = [LPExercise exerciseWithDictionary:exerciseDictionary];
                    [newExercises addObject:exercise];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.exercises = newExercises;
                    [self.exercisesTableView reloadData];
                });
            }
        } else {
            NSLog(@"---> %@", error.description);
        }
    }];
    [task resume];
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _exercises.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseCell" forIndexPath:indexPath];
    LPExercise *exercise = _exercises[indexPath.row];
    cell.textLabel.text = exercise.name;
    return cell;
}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LPExercise *exercise = _exercises[indexPath.row];
    if (exercise) {
        [self performSegueWithIdentifier:@"StartExercise" sender:exercise];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StartExercise"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        LPExerciseViewController *vc = (LPExerciseViewController *)nav.visibleViewController;
        vc.exercise = (LPExercise *)sender;
    }
}

@end

//
//  ViewController.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/6/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "ViewController.h"

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
                NSMutableArray *exerciseTitles = [[NSMutableArray alloc] init];
                for (NSDictionary *exercise in exercises) {
                    NSString *exerciseTitle = exercise[@"name"];
                    [exerciseTitles addObject:exerciseTitle];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.exercises = exerciseTitles;
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
    cell.textLabel.text = _exercises[indexPath.row];
    return cell;
}

@end

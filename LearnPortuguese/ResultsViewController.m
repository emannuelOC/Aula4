//
//  ResultsViewController.m
//  LearnPortuguese
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/7/16.
//  Copyright © 2016 Emannuel Carvalho. All rights reserved.
//

#import "ResultsViewController.h"
#import "AppDelegate.h"
#import "LPResult.h"

@interface ResultsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (strong, nonatomic) NSArray *results;
@end

@implementation ResultsViewController

#pragma mark - ViewController life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    _results = [LPResult getAllResults:context];
    [_resultsTableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResults) name:@"LPDidUpdateResults" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell" forIndexPath:indexPath];
    LPResult *result = _results[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", result.exerciseName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", result.generalResult.floatValue];
    return cell;
}

#pragma mark - TableView delegate

#pragma mark - Observer methods

- (void)updateResults {
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    _results = [LPResult getAllResults:context];
    [_resultsTableView reloadData];
}

@end

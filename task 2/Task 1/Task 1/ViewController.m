//
//  ViewController.m
//  Task 1
//
//  Created by Anatoliy on 1/31/16.
//  Copyright © 2016 mobex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *array;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [[NSMutableArray alloc] init];

}

- (IBAction)startCalculation:(id)sender {
    
    self.operationQueue = [NSOperationQueue new];
    [self.operationQueue addOperationWithBlock:^{
        int fcounter = 300; // specifies the number of values to loop through
        NSDecimalNumber *f1 = [NSDecimalNumber decimalNumberWithString:@"1.0"]; // seed value 1
        NSDecimalNumber *f2 = [NSDecimalNumber decimalNumberWithString:@"0.0"]; // seed value 2
        NSDecimalNumber *fn; // used as a holder for each new value in the loop
        
        for (int i = 1; i <= fcounter; i++) {
            fn = [f1 decimalNumberByAdding:f2];
            f1 = f2;
            f2 = fn;
            
            if (i%10 == 0) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.array addObject:fn];
                    
                    [self.table beginUpdates];
                    [self.table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.array.count - 1 inSection:0]]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self.table endUpdates];
                }];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.array objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

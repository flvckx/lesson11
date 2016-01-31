//
//  ViewController.m
//  Task3
//
//  Created by Anatoliy on 1/31/16.
//  Copyright © 2016 mobex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSArray *pictures;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pictures = @[@"http://justsomething.co/wp-content/uploads/2013/09/housesmexico.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/michaelbrandt.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/andreermolaevphoto11.jpeg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/paint.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/dunes.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/painting.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/trees.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/wave.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/painting30.jpg",
                      @"http://justsomething.co/wp-content/uploads/2013/09/barbaracolepaintedladies1.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    dispatch_queue_t downloadQueue = dispatch_queue_create("image loader", NULL);
//    dispatch_async(downloadQueue, ^{
//        double loadTotalTime = 0.0;
//        for (int i = 0; i < [self.pictures count]; i++) {
//            NSDate *loadStart = [NSDate date];
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.pictures[i]]]; // long time!
//            NSDate *loadEnd = [NSDate date];
//            dispatch_async(dispatch_get_main_queue(), ^ {
//                UIImage *image = [UIImage imageWithData:imageData];
//                self.imageView.image = image;
//                self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//            });
//            loadTotalTime += [loadEnd timeIntervalSinceDate:loadStart];
//            NSLog(@"load time: %f", [loadEnd timeIntervalSinceDate:loadStart]);
//            [NSThread sleepForTimeInterval:2.0];
//        }
//        NSLog(@"entire time for loading: %f", loadTotalTime);
//    });
//    //dispatch_release(downloadQueue);
//    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        double loadTotalTime = 0.0;
        for (int i = 0; i < [self.pictures count]; i++) {
            NSDate *loadStart = [NSDate date];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.pictures[i]]]; // long time!
            NSDate *loadEnd = [NSDate date];
            dispatch_async(dispatch_get_main_queue(), ^ {
                UIImage *image = [UIImage imageWithData:imageData];
                self.imageView.image = image;
                self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            });
            loadTotalTime += [loadEnd timeIntervalSinceDate:loadStart];
            //NSLog(@"load time: %f", [loadEnd timeIntervalSinceDate:loadStart]);
            [NSThread sleepForTimeInterval:0.3];
        }
        NSLog(@"entire time for loading: %f", loadTotalTime);
    });
}

@end

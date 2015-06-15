//
//  ViewController.m
//  SpacingLabelDemo
//
//  Created by Cyril Chandelier on 15/06/15.
//  Copyright (c) 2015 Cyril Chandelier. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

// Outlets
@property (nonatomic, weak) IBOutlet UILabel *topLabel;
@property (nonatomic, weak) IBOutlet UILabel *middleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bottomLabel;

@end



@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.topLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non sodales quam, non faucibus justo. Donec blandit vitae est nec molestie.";
    self.middleLabel.text = @"In bibendum pretium dolor, at pharetra est iaculis vel. Integer quis venenatis lorem. Morbi in elit ullamcorper, eleifend est eu, ultrices risus.";
    self.bottomLabel.text = @"Aliquam sollicitudin, ante vel fermentum pellentesque, felis sem dapibus leo, id maximus diam mauris sed orci.";
}

@end

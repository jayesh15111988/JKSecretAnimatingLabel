//
//  ViewController.m
//  JKSecretAnimatingLabel
//
//  Created by Jayesh Kawli Backup on 3/22/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ViewController.h"
#import "JKSecretAnimatingLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet JKSecretAnimatingLabel *pictureDescriptionLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureDescriptionLabel animateWithIndividualTextAnimationDuration:0.02];
}

@end

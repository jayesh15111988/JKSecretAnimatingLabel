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
@property (weak, nonatomic) IBOutlet JKSecretAnimatingLabel *anotherPictureDescriptionLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictureDescriptionLabel.textColor = [UIColor purpleColor];
    self.pictureDescriptionLabel.alpha = 0.0;
    [self.pictureDescriptionLabel animateAndShowWithIndividualTextAnimationDuration:3 andCompletionBlock:^{
        
    }];
    [self.anotherPictureDescriptionLabel animateColorTransitionWithAnimationDuration:3 andInitialColor:[UIColor redColor] andFinalColor:[UIColor purpleColor] andCompletionBlock:^{
        
    }];
}

@end

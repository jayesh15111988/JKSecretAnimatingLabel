//
//  JKSecretAnimatingLabel.h
//  JKSecretAnimatingLabel
//
//  Created by Jayesh Kawli Backup on 3/22/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKSecretAnimatingLabel : UILabel
-(void)animateWithIndividualTextAnimationDuration:(NSTimeInterval)animationDuration andRange:(NSRange)rangeToAnimate;
@end


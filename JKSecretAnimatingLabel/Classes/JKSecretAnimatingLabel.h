//
//  JKSecretAnimatingLabel.h
//  JKSecretAnimatingLabel
//
//  Created by Jayesh Kawli Backup on 3/22/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AnimationCompletionBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface JKSecretAnimatingLabel : UILabel

- (void)animateAndShowWithIndividualTextAnimationDuration:(NSTimeInterval)animationDuration andCompletionBlock:(nullable AnimationCompletionBlock)block;
- (void)animateColorTransitionWithAnimationDuration:(NSTimeInterval)animationDuration andInitialColor:(UIColor*)initialColor andFinalColor:(UIColor*)finalColor andCompletionBlock:(nullable AnimationCompletionBlock)block;

@end

NS_ASSUME_NONNULL_END

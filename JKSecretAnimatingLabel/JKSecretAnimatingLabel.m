//
//  JKSecretAnimatingLabel.m
//  JKSecretAnimatingLabel
//
//  Created by Jayesh Kawli Backup on 3/22/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKSecretAnimatingLabel.h"

@interface JKSecretAnimatingLabel ()
@property (strong) NSTimer* textAnimationTimer;
@property (assign) NSInteger attributedStringIndexToUpdate;
@property (strong) NSArray* shuffledArrayOfIndices;
@property (assign) NSTimeInterval individualTextAnimationDuration;
@end

@implementation JKSecretAnimatingLabel

-(void)animateWithIndividualTextAnimationDuration:(NSTimeInterval)animationDuration {
    self.individualTextAnimationDuration = animationDuration;

    self.attributedStringIndexToUpdate = 0;
    [self setShuffledIndicesArray];
    [self setupForSecretTextAnimation];
}

-(void)setupForSecretTextAnimation {
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    CGFloat whiteColorShade = 0;
    CGFloat individualTextAlpha = 0;
    NSInteger stringLength = attributedString.length;
    for(NSInteger i = 0; i < stringLength; i++) {
        individualTextAlpha = (rand()/(CGFloat)INT_MAX);
        whiteColorShade = (NSInteger)(individualTextAlpha*100)%255;
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:whiteColorShade/255.0 alpha:individualTextAlpha] range:NSMakeRange(i, 1)];
        self.attributedText = attributedString;
    }
    
    self.textAnimationTimer = [NSTimer timerWithTimeInterval:self.individualTextAnimationDuration target:self selector:@selector(updateTextColorAndAlpha) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.textAnimationTimer forMode:NSDefaultRunLoopMode];
}

- (void)setShuffledIndicesArray {
    NSMutableArray* shuffledArray = [[NSMutableArray alloc] init];
    NSUInteger descriptionLength = self.text.length;
    for(NSInteger i = 0; i< descriptionLength; i++) {
        [shuffledArray addObject:@(i)];
    }
    
    for (NSUInteger i = 0; i < descriptionLength; ++i) {
        NSInteger remainingCount = descriptionLength - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    self.shuffledArrayOfIndices = shuffledArray;
}

-(void)updateTextColorAndAlpha {
    NSInteger indexToProcess = [self.shuffledArrayOfIndices[self.attributedStringIndexToUpdate++] integerValue];
    NSRange range = NSMakeRange(indexToProcess, 1);
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    UIColor* colorAttributeForCurrentIndex = [attributedString attribute:NSForegroundColorAttributeName atIndex:indexToProcess longestEffectiveRange:&range inRange:range];
    if(CGColorGetAlpha(colorAttributeForCurrentIndex.CGColor) < 1.0){
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(indexToProcess, 1)];
    }
    self.alpha = (CGFloat)(self.attributedStringIndexToUpdate/(CGFloat)self.text.length)*0.75;
    
    self.attributedText = attributedString;
    
    if(self.attributedStringIndexToUpdate >= self.text.length) {
        [self.textAnimationTimer invalidate];
        self.textAnimationTimer = nil;
        [UIView animateWithDuration:1.0 animations:^{
            self.alpha = 1.0;
        }];
    }
}

@end

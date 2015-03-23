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
@property (assign) NSInteger beginIndexToAnimate;
@property (assign) NSInteger endIndexToAnimate;
@property (assign) NSInteger animatingLength;
@end

@implementation JKSecretAnimatingLabel

-(void)animateWithIndividualTextAnimationDuration:(NSTimeInterval)animationDuration andRange:(NSRange)rangeToAnimate{
    self.individualTextAnimationDuration = animationDuration;
    self.attributedStringIndexToUpdate = rangeToAnimate.location;
    _beginIndexToAnimate = rangeToAnimate.location;
    _endIndexToAnimate = rangeToAnimate.location + rangeToAnimate.length - 1;
    self.animatingLength = rangeToAnimate.length;
    NSAssert(self.endIndexToAnimate < self.text.length, @"Range exceeded than length of input label");
    [self setShuffledIndicesArray];
    [self setupForSecretTextAnimation];
}

-(void)setupForSecretTextAnimation {
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    CGFloat whiteColorShade = 0;
    CGFloat individualTextAlpha = 0;

    for(NSInteger i = self.beginIndexToAnimate; i <= self.endIndexToAnimate; i++) {
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
    NSUInteger descriptionLength = self.animatingLength;
    for(NSInteger i = self.beginIndexToAnimate; i <= self.endIndexToAnimate; i++) {
        [shuffledArray addObject:@(i)];
    }
    
    for (NSUInteger i = self.beginIndexToAnimate; i <= self.endIndexToAnimate; ++i) {
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
    
    if(self.attributedStringIndexToUpdate >= self.animatingLength) {
        [self.textAnimationTimer invalidate];
        self.textAnimationTimer = nil;
        [UIView animateWithDuration:1.0 animations:^{
            self.alpha = 1.0;
        }];
    }
}

@end

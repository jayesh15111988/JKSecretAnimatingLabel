//
//  JKSecretAnimatingLabel.m
//  JKSecretAnimatingLabel
//
//  Created by Jayesh Kawli Backup on 3/22/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKSecretAnimatingLabel.h"

@interface JKSecretAnimatingLabel ()

@property (nonatomic, strong) NSTimer* textAnimationTimer;
@property (nonatomic, assign) NSInteger attributedStringIndexToUpdate;
@property (nonatomic, copy)   NSArray* shuffledArrayOfIndices;
@property (nonatomic, assign) NSTimeInterval individualTextAnimationDuration;
@property (nonatomic, assign) NSInteger beginIndexToAnimate;
@property (nonatomic, assign) NSInteger endIndexToAnimate;
@property (nonatomic, assign) NSInteger animatingLength;
@property (nonatomic, assign) CGFloat redColor;
@property (nonatomic, assign) CGFloat greenColor;
@property (nonatomic, assign) CGFloat blueColor;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, strong) UIColor* originalColor;
@property (nonatomic, strong) UIColor* initialColor;
@property (nonatomic, strong) UIColor* finalColor;
@property (nonatomic, strong) AnimationCompletionBlock completionBlock;

@end

@implementation JKSecretAnimatingLabel

-(void)animateWithIndividualTextAnimationDuration:(NSTimeInterval)animationDuration andCompletionBlock:(AnimationCompletionBlock)block {
    [self initializeParametersWithAnimationDuration:animationDuration];
    self.originalColor = self.textColor;
    [self.originalColor getRed:&_redColor green:&_greenColor blue:&_blueColor alpha:&_alpha];
    //This is to avoid bug when user provided range has exceeded the length of input label text string. Range should always remain within limit
    NSAssert2(self.endIndexToAnimate < self.text.length, @"Range exceeded than length of the input label. Label title lest index %ld. Input end index encountered %ld", (long)self.text.length - 1, (long)self.endIndexToAnimate);
    self.completionBlock = block;
    [self setShuffledIndicesArray];
    [self setupForSecretTextAnimation];
}

- (void)animateColorTransitionWithAnimationDuration:(NSTimeInterval)animationDuration andInitialColor:(UIColor*)initialColor andFinalColor:(UIColor*)finalColor andCompletionBlock:(AnimationCompletionBlock)block {
    [self initializeParametersWithAnimationDuration:animationDuration];
    self.initialColor = initialColor;
    self.finalColor = finalColor;
    self.completionBlock = block;
    [self setShuffledIndicesArray];
    [self setShuffledIndicesArrayForColorChange];
}

- (void)initializeParametersWithAnimationDuration:(NSTimeInterval)animationDuration {
    NSRange rangeToAnimate = NSMakeRange(0, self.text.length);
    self.individualTextAnimationDuration = animationDuration/self.text.length;
    self.attributedStringIndexToUpdate = rangeToAnimate.location;
    self.beginIndexToAnimate = rangeToAnimate.location;
    self.endIndexToAnimate = rangeToAnimate.location + rangeToAnimate.length - 1;
    self.animatingLength = rangeToAnimate.length;
}

- (void)setShuffledIndicesArrayForColorChange {
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    for(NSInteger i = self.beginIndexToAnimate; i <= self.endIndexToAnimate; i++) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.initialColor range:NSMakeRange(i, 1)];
        self.attributedText = attributedString;
    }
    
    self.textAnimationTimer = [NSTimer timerWithTimeInterval:self.individualTextAnimationDuration target:self selector:@selector(updateTextColor) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.textAnimationTimer forMode:NSDefaultRunLoopMode];
}

-(void)setupForSecretTextAnimation {
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    CGFloat individualTextAlpha = 0;

    for(NSInteger i = self.beginIndexToAnimate; i <= self.endIndexToAnimate; i++) {
        individualTextAlpha = (rand()/(CGFloat)INT_MAX);
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:_redColor green:_greenColor  blue:_blueColor alpha:individualTextAlpha] range:NSMakeRange(i, 1)];
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
        NSInteger adjustedIndex = i - self.beginIndexToAnimate;
        NSInteger remainingCount = descriptionLength - adjustedIndex;
        NSInteger exchangeIndex = adjustedIndex + arc4random_uniform((u_int32_t )remainingCount);
        [shuffledArray exchangeObjectAtIndex:adjustedIndex withObjectAtIndex:exchangeIndex];
    }
    self.shuffledArrayOfIndices = shuffledArray;
}

-(void)updateTextColor {
    NSInteger indexToProcess = [self.shuffledArrayOfIndices[self.attributedStringIndexToUpdate - self.beginIndexToAnimate] integerValue];
    self.attributedStringIndexToUpdate++;
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.finalColor range:NSMakeRange(indexToProcess, 1)];
    
    self.attributedText = attributedString;
    
    if(self.attributedStringIndexToUpdate >= self.animatingLength + self.beginIndexToAnimate) {
        [self.textAnimationTimer invalidate];
        self.textAnimationTimer = nil;
        if(self.animatingLength == self.text.length) {
            self.textColor = self.finalColor;
            if (self.completionBlock) {
                self.completionBlock();
            }
        }
    }
}

-(void)updateTextColorAndAlpha {
    NSInteger indexToProcess = [self.shuffledArrayOfIndices[self.attributedStringIndexToUpdate - self.beginIndexToAnimate] integerValue];
    self.attributedStringIndexToUpdate++;
    NSRange range = NSMakeRange(indexToProcess, 1);
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    UIColor* colorAttributeForCurrentIndex = [attributedString attribute:NSForegroundColorAttributeName atIndex:indexToProcess longestEffectiveRange:&range inRange:range];
    if(CGColorGetAlpha(colorAttributeForCurrentIndex.CGColor) < 1.0){
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.originalColor range:NSMakeRange(indexToProcess, 1)];
    }
    
    if(self.animatingLength == self.text.length) {
        self.alpha = (CGFloat)(self.attributedStringIndexToUpdate/(CGFloat)self.text.length) * 0.75;
    }
    
    self.attributedText = attributedString;
    
    if(self.attributedStringIndexToUpdate >= self.animatingLength + self.beginIndexToAnimate) {
        [self.textAnimationTimer invalidate];
        self.textAnimationTimer = nil;
        if(self.animatingLength == self.text.length) {
            self.alpha = 1.0;
            if (self.completionBlock) {
                self.completionBlock();
            }
        }
    }
}

@end

# JKSecretAnimatingLabel
__A library to make the shiny, secret label animation__

> Please note the updates for version 2.0. Version 1.0 has been deprecated in favor of version 2.0.

(Inspired from <a href='http://natashatherobot.com/secret-ios-app-text-animation/'>Replicating The Secret iOS App Text Animation</a>)

![alt text][SecretLabelAnimationDemo]

If you're using Cocoapods, just include the following line to your `podfile`<br/><br/>
**pod 'JKSecretAnimatingLabel', :git => 'https://github.com/jayesh15111988/JKSecretAnimatingLabel.git' , :branch => 'master'**

Usage is very easy. Just subclass your label to ```JKSecretAnimatingLabel``` 
```
//In a class interface
@property (weak, nonatomic) IBOutlet JKSecretAnimatingLabel *pictureDescriptionLabel;
```
Call the following method to start a fade in animation.
```
[self.pictureDescriptionLabel animateWithIndividualTextAnimationDuration:3.0 andCompletionBlock:^{
    // Note that completion block is optional. It's used just for a callback when animation finishes.     
}];
```

If you want to perform color change animation from initial color to the final one, please call following method on `JKSecretAnimatingLabel` instance

```
[self.pictureDescriptionLabel animateColorTransitionWithAnimationDuration:3.0 andInitialColor:[UIColor redColor] andFinalColor:[UIColor purpleColor] andCompletionBlock:^{
    // Completion block which gets called once animation is complete.       
}];
```

**Additional animation parameters : **

 - __Individual text animation duration__ :
This is the value of total animation duration to perform full animation - Either fade in or color change.

- __Initial color__ :
This is the value of initial color from where animation will begin to transition to final color value.

- __Final color__ :
This is the value of final color to where animation will stop. 

- __Completion Block__ :
This is the final completion block which gets called once animation is finished. This is an optional parameter. If you don't want to utilize it, simply pass the `null` value to the parameter.

[SecretLabelAnimationDemo]: https://github.com/jayesh15111988/JKSecretAnimatingLabel/blob/master/Screenshots/demo_updated.gif 
"Secret Animated label demo"

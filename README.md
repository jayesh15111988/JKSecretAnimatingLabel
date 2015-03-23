# JKSecretAnimatingLabel
__A library to make the shiny, secret label animation__

(Inspired from <a href='http://natashatherobot.com/secret-ios-app-text-animation/'>Replicating The Secret iOS App Text Animation</a>)

![alt text][SecretLabelAnimationDemo]

Usage is very easy. Just subclass your label to ```JKSecretAnimatingLabel``` 
```
//In a class interface
@property (weak, nonatomic) IBOutlet JKSecretAnimatingLabel *pictureDescriptionLabel;
```
Call the following method to start an animation.
```
[self.pictureDescriptionLabel animateWithIndividualTextAnimationDuration:0.04 andRange:NSMakeRange(0, self.pictureDescriptionLabel.text.length)];
```

**Additional animation parameters : **

 - __Individual text animation duration__ :
Decides animation duration for individual text character. i.e. if animation text length is ```n``` and individual text animation interval is ```t```. Animation of full label will take total of ```(t*n)``` seconds. Note that
you might want to keep value of ```t``` comparatively small for longer texts to avoid animation delay.

- __Animation length__ : 
Specialty of this library is that user can specify the range of text to animate. It has same usage as ```NSMakeRange(location, length)``` method. First parameter specifies the index location from which animation would begin and
second character specifies the length of characters to animate from specified position.

[SecretLabelAnimationDemo]: https://github.com/jayesh15111988/JKSecretAnimatingLabel/blob/master/Screenshots/SecretAnimationDemo.gif 
"Secret Animated label demo"

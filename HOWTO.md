ESPSlider
=========

ESPSlider is a custom UIView that works like a rating UISlider, it changes values by touching or by draging inside.

See it in action: https://vimeo.com/92618816

To install you can basically drag .h and .m files to your project, import and configure or you can simple add to your Podfile

```ruby
pod 'ESPSlider', '~> 1.0'
```

For use it, you can simply instantiate ESPSlider programatically:

```objc
ESPSlider *slider = [[ESPSlider alloc] initWithFrame:CGRectMake(20.0, 20.0, 300.0, 30.0)];
[self.view addSubview:slider];
```
Or you can add a UIView to your Storyboard/xib, set Custom Class to ESPSlider and add an IBOutlet to configure the component.

![Setting Custom Class](https://dl.dropboxusercontent.com/s/4gwg8ajtm0tdtle/image1.png?dl=1&token_hash=AAE3DPdcKsZoU389sug4_UUjq6sOXT-ZMhMluw_RsoaBSA)

```objc
@property (nonatomic, strong) IBOutlet ESPSlider *slider;
```

![Setting Outlet](https://dl.dropboxusercontent.com/s/rvd1nrb5bnppqwo/image2.png?token_hash=AAGhcV4rGh4azi930HFKh61m5arYNu6RvEjSJoBXKw6KNA)

After that, you only need to do is to configure component:

```objc
slider.minimumSize = CGSizeMake(20.0, 30.0);
[slider setImage:[UIImage imageNamed:@"normal"] forState:ESPSliderStateNormal];
[slider setImage:[UIImage imageNamed:@"selected"] forState:ESPSliderStateSelected];
slider.minimumValue = 2;
slider.maximumValue = 7;
```
And set the value change block:

```objc
[self.slider setValueChangedBlock:^(CGFloat value){
	// Do something with current value
}];
```

**The whole component is based on Ray Wenderlich 5 Star Rating View tutorial:**

http://www.raywenderlich.com/1768/uiview-tutorial-for-ios-how-to-make-a-custom-uiview-in-ios-5-a-5-star-rating-view

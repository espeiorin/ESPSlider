//
//  ESPSlider.m
//  ESPSlider
//
//  Created by André Gustavo Espeiorin on 16/04/14.
//  Copyright (c) 2014 Coderockr. All rights reserved.
//

#import "ESPSlider.h"

@interface ESPSlider ()

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSMutableArray *imageViews;

- (void) initializeSlider;
- (void) refreshSubviews;
- (void) handleTouch:(UITouch *)touch;

@end

@implementation ESPSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSlider];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeSlider];
    }
    return self;
}


#pragma mark - Instance Methods
- (void) initializeSlider
{
    self.value = 0.0;
    self.minimumValue = 0.0;
    self.maximumValue = 0.0;
    self.edgeMargin = 5.0;
    self.innerMargin = 2.0;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (self.normalImage == nil) {
        return;
    }
    
    CGFloat imageWidth = floorf((CGRectGetWidth(self.frame) - (self.edgeMargin * 2) - (self.innerMargin * self.subviews.count)) / self.imageViews.count);
    imageWidth = fmaxf(imageWidth, self.minimumSize.width);
    CGFloat imageHeight = fmaxf(CGRectGetHeight(self.frame), self.minimumSize.height);
    
    NSUInteger subviewCount = self.imageViews.count;
    for (NSUInteger i = 0; i < subviewCount; i++) {
        UIImageView *imageView = self.imageViews[i];
        imageView.frame = (CGRect){
            {
                self.edgeMargin + (i * (self.innerMargin + imageWidth)),
                0.0
            },
            {
                imageWidth,
                imageHeight
            }
        };
    }
}

- (void) refreshSubviews
{
    NSUInteger subviewCount = self.imageViews.count;
    for (NSUInteger i = 0; i < subviewCount; i++) {
        UIImageView *imageView = self.imageViews[i];
        if (self.value >= imageView.tag) {
            imageView.image = self.selectedImage;
        } else {
            imageView.image = self.normalImage;
        }
    }
}

#pragma mark - Setters
- (void) setImage:(UIImage *)image forState:(ESPSliderState)state;
{
    switch (state) {
        case ESPSliderStateNormal:
            self.normalImage = image;
            break;
        case ESPSliderStateSelected:
            self.selectedImage = image;
            break;
        default:
            break;
    }
}

- (void) setMaximumValue:(CGFloat)maximumValue
{
    _maximumValue = maximumValue;
    
    if (self.imageViews.count > 0) {
        [self.imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.imageViews removeAllObjects];
    }
    
    for (NSUInteger i = self.minimumValue; i <= self.maximumValue; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = i;
        NSLog(@"%lu", (unsigned long)i);
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    [self setNeedsLayout];
    [self refreshSubviews];
}

- (void) setMinimumValue:(CGFloat)minimumValue
{
    _minimumValue = minimumValue;
    if (self.maximumValue > self.minimumValue) {
        [self setMaximumValue:self.maximumValue];
    }
}

- (void) setValue:(CGFloat)value
{
    _value = value;
    [self refreshSubviews];
}

#pragma mark - Getters
- (NSMutableArray *) imageViews
{
    if (_imageViews == nil) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

#pragma mark - Gesture Recognition
- (void) handleTouch:(UITouch *)touch
{
    if (self.isLocked) {
        return;
    }
    
    CGPoint position = [touch locationInView:self];
    CGFloat newValue = 0.0;
    
    NSUInteger subviewCount = self.imageViews.count;
    for (NSInteger i = (subviewCount - 1); i >= 0; i--) {
        UIImageView *imageView = self.imageViews[i];
        if (position.x > CGRectGetMinX(imageView.frame)) {
            newValue = imageView.tag;
            break;
        }
    }
    
    self.value = newValue;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.valueChangedBlock != NULL) {
        self.valueChangedBlock(self.value);
    }
}

@end
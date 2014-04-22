//
//  ESPSlider.h
//  ESPSlider
//
//  Created by André Gustavo Espeiorin on 16/04/14.
//  Copyright (c) 2014 Coderockr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ESPSliderChangedValue)(CGFloat value);
typedef enum {
    ESPSliderStateNormal,
    ESPSliderStateSelected
} ESPSliderState;

@interface ESPSlider : UIView

@property (nonatomic, strong) ESPSliderChangedValue valueChangedBlock;
@property (nonatomic) CGFloat value;
@property (nonatomic) CGFloat minimumValue;
@property (nonatomic) CGFloat maximumValue;
@property (nonatomic) CGFloat edgeMargin;
@property (nonatomic) CGFloat innerMargin;
@property (nonatomic) CGSize minimumSize;

@property (nonatomic, getter = isLocked) BOOL locked;

- (void) setImage:(UIImage *)image forState:(ESPSliderState)state;

@end
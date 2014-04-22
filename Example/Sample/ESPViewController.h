//
//  ESPViewController.h
//  Sample
//
//  Created by André Gustavo Espeiorin on 22/04/14.
//  Copyright (c) 2014 Coderockr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESPSlider/ESPSlider.h>

@interface ESPViewController : UIViewController

@property (nonatomic, strong) IBOutlet ESPSlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *label;

@end

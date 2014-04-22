//
//  ESPViewController.m
//  Sample
//
//  Created by André Gustavo Espeiorin on 22/04/14.
//  Copyright (c) 2014 Coderockr. All rights reserved.
//

#import "ESPViewController.h"

@interface ESPViewController ()

@end

@implementation ESPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.slider.minimumSize = CGSizeMake(20.0, 30.0);
    [self.slider setImage:[UIImage imageNamed:@"normal"] forState:ESPSliderStateNormal];
    [self.slider setImage:[UIImage imageNamed:@"selected"] forState:ESPSliderStateSelected];
    self.slider.minimumValue = 2;
    self.slider.maximumValue = 7;
    self.slider.value = 2;
    
	__unsafe_unretained typeof(self) weakSelf = self;
    [self.slider setValueChangedBlock:^(CGFloat value){
        weakSelf.label.text = [NSString stringWithFormat:@"VALUE %f", value];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

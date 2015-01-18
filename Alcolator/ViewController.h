//
//  ViewController.h
//  Alcolator
//
//  Created by Man Hong Lee on 1/13/15.
//  Copyright (c) 2015 ManHong Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UILabel *numberOfBeer;

-(void)buttonPressed:(UIButton *)sender;


@end


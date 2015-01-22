//
//  ViewController.m
//  Alcolator
//
//  Created by Man Hong Lee on 1/13/15.
//  Copyright (c) 2015 ManHong Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)loadView {
    //Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    //Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider =[[UISlider alloc]init];
    UILabel *label = [[UILabel alloc]init];
    UILabel *beerlabel = [[UILabel alloc]init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    
    //add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:beerlabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.numberOfBeer = beerlabel;
    self. calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Wine", @"wine");
    // Do any additional setup after loading the view, typically from a nib.
    // Calls the superclass's implementation

    //Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.resultLabel.backgroundColor = [UIColor blueColor];
    //Tells the text field that 'self', this instance of 'BLCViewController' should be treated as the text field's delegate
    self.beerPercentTextField.delegate  = self;
    
    //Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    //Tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderValueDidChange:]'.
    //This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    //set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    //Tells 'self.calculateButton' that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Set the title of the button
    [self.calculateButton  setTitle:NSLocalizedString(@"Calculate", @"Calculate command" ) forState:UIControlStateNormal];
    
    //Tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tao.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    self.numberOfBeer.numberOfLines=0;
    //Get rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
    self.nameOfBeverage = @"Wine";
    self.nameOfContainer = @"Glasses";
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding =20;
    CGFloat itemWidth= viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding+40, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.numberOfBeer.frame = CGRectMake(padding, bottomOfSlider +padding, itemWidth, itemHeight);
    
    CGFloat bottomOfNumberOfBeer = CGRectGetMaxY(self.numberOfBeer.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfNumberOfBeer + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    
    [self.beerPercentTextField resignFirstResponder];
    NSString *numOfBeer= [NSString stringWithFormat:NSLocalizedString(@"%f", nil), sender.value];
    self.numberOfBeer.text=numOfBeer;
    
//    Wine (123 glasses)
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (%f %@)",self.nameOfBeverage, sender.value,self.nameOfContainer];
    
    
}
    
- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue]/100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal= ouncesOfAlcoholPerBeer * numberOfBeers;
    float ouncesInOneWineGlass=5;
    float alcoholPercentageOfWine=0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal/ouncesOfAlcoholPerWineGlass;
    NSString *beerText;
    if (numberOfBeers ==1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers",@"plural of beer");
    }
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount ==1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses",@"plural of glass");
    }
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.lf %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text= resultText;
}
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end

//
//  TipViewController.m
//  protip
//
//  Created by Jatin Pandey on 1/19/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"ProTip";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipArray = @[@(0.1), @(0.15), @(0.2)];
    float tipPercent = [tipArray[self.tipControl.selectedSegmentIndex] floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger storedTip = [defaults integerForKey:@"default_tip_percentage"];
    NSString *theme = [defaults objectForKey:@"theme"];
    if (storedTip) {
        self.tipPercentage.text = [NSString stringWithFormat:@"%ld%%", (long)storedTip];
        float floatTip = (float)storedTip;
        tipPercent = floatTip/100;
        [defaults removeObjectForKey:@"default_tip_percentage"];
        [defaults synchronize];
    }
    else {
        self.tipPercentage.text = [NSString stringWithFormat:@"%.0f%%", tipPercent * 100];
    }
    if ([theme isEqual: @"light"]) {
        NSLog(@"Light");
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        NSLog(@"Dark");
        self.view.backgroundColor = [UIColor colorWithRed:160/256.0 green:160/256.0 blue:200/256.0 alpha:1.0];
    }
    float tipAmount = billAmount * tipPercent;
    float totalAmount = billAmount + tipAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", totalAmount];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) onSettingsButton {
    NSLog(@"Tapped Settings");
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end



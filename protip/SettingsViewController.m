//
//  SettingsViewController.m
//  protip
//
//  Created by Jatin Pandey on 1/19/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipViewController.h"

@interface SettingsViewController ()
- (IBAction)onSetDefaultTip:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *defaultTipPercentage;
- (IBAction)onLightTheme:(id)sender;
- (IBAction)onDarkTheme:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSetDefaultTip:(id)sender {
    int defaultTip = [self.defaultTipPercentage.text integerValue];
    NSLog(@"Set default of %d%%", defaultTip);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:defaultTip forKey:@"default_tip_percentage"];
    [defaults synchronize];
    TipViewController *tvc = (TipViewController *)self.presentingViewController;
    [tvc updateValues];
}

- (IBAction)onLightTheme:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"light" forKey:@"theme"];
    [defaults synchronize];
    TipViewController *tvc = (TipViewController *)self.presentingViewController;
    [tvc updateValues];
}

- (IBAction)onDarkTheme:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"dark" forKey:@"theme"];
    [defaults synchronize];
    TipViewController *tvc = (TipViewController *)self.presentingViewController;
    [tvc updateValues];
}

@end

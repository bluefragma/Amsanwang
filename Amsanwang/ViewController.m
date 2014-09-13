//
//  ViewController.m
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    int answer = [self.leftOperandLabel.text intValue] + [self.rightOperandLabel.text intValue];
    if (answer == [self.answerField.text intValue]) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"정답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
    else {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"오답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
}

@end

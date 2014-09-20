//
//  ViewController.m
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import "ViewController.h"

@interface ViewController ()

- (NSInteger)integerRandomValue:(NSInteger)aNumber;
- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib. 

    self.leftOperandLabel.text = [NSString stringWithFormat:@"%d", [self integerRandomValue:9]];
    self.rightOperandLabel.text = [NSString stringWithFormat:@"%d", [self integerRandomValue:9]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    int answer = [self additionWithNumber:[self.leftOperandLabel.text intValue] otherNumber:[self.rightOperandLabel.text intValue]];
    if (answer == [self.answerField.text intValue]) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"정답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
    else {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"오답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
}

#pragma mark - Private

- (NSInteger)integerRandomValue:(NSInteger)aNumber
{
    // arc4random_uniform(N) 함수는 0 에서 N-1 까지의 정수 난수를 생성한다.
    // 0은 계산에서 제외하므로 +1을 한다.
    int value = arc4random_uniform(aNumber)+1;
    return value;
}

- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    int value = aNumber + otherNumber;
    return value;
}

- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    int value = aNumber - otherNumber;
    return value;
}

- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    int value = aNumber * otherNumber;
    return value;
}

@end

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

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 라벨에 난수를 할당한다.
    self.leftOperandLabel.text = [NSString stringWithFormat:@"%d", [self integerRandomValue:9]];
    self.rightOperandLabel.text = [NSString stringWithFormat:@"%d", [self integerRandomValue:9]];
    // 위와 같은 내용의 다른 구현.
    // self.leftOperandLabel.text = [@([self integerRandomValue:9]) stringValue];
    // self.rightOperandLabel.text = [@([self integerRandomValue:9]) stringValue];
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

#pragma mark - Private

- (NSInteger)integerRandomValue:(NSInteger)aNumber
{
    // arc4random_uniform(N) 함수는 0 에서 N-1 까지의 정수 난수를 생성한다.
    // 0은 계산에서 제외하므로 +1을 한다.
    int value = arc4random_uniform(aNumber)+1;
    return value;
}

@end

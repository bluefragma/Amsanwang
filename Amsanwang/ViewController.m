//
//  ViewController.m
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import "ViewController.h"

// 연산자 열거형.
typedef NS_ENUM(NSInteger, ASWOperator) {
    ASWOperatorAddition,
    ASWOperatorSubtraction,
    ASWOperatorMultiplication,
    ASWOperatorDivision
};

// 연산자 기호.
static NSString * const kASWOperatorStringAddition = @"+";
static NSString * const kASWOperatorStringSubtraction = @"−";
static NSString * const kASWOperatorStringMultiplication = @"×";
static NSString * const kASWOperatorStringDivision = @"÷";

@interface ViewController ()

@property (assign, nonatomic) ASWOperator currentOperator;
@property (assign, nonatomic) NSRange operandRange;
@property (assign, nonatomic) NSRange operatorRange;

- (NSInteger)integerRandomValueWithRange:(NSRange)range;
- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSString *)stringOperator:(ASWOperator)anOperator;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 피연산자 선택 범위.
    // 첫 번째 인자는 시작 값, 두 번째 인자는 길이.
    // NSMakeRange(0, 9)는 0부터 8까지를 나타낸다.
    self.operandRange = NSMakeRange(1, 9);
    
    // 좌우 라벨에 난수를 할당한다.
    // NSInteger 값을 NSNumber 리터럴 표현식으로 바꾸고, 다시 문자열 값으로 변경한다.
    self.leftOperandLabel.text = [@([self integerRandomValueWithRange:self.operandRange]) stringValue];
    self.rightOperandLabel.text = [@([self integerRandomValueWithRange:self.operandRange]) stringValue];
    
    // 연산자 선택 범위.
    self.operatorRange = NSMakeRange(0, 3);
    
    // 연산자 랜덤 선택.
    self.currentOperator = [self integerRandomValueWithRange:self.operatorRange];
    self.operatorLabel.text = [self stringOperator:self.currentOperator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    NSInteger answer;
    switch (self.currentOperator) {
        case ASWOperatorAddition:
            answer = [self additionWithNumber:[self.leftOperandLabel.text intValue] otherNumber:[self.rightOperandLabel.text intValue]];
            break;
            
        case ASWOperatorSubtraction:
            answer = [self subtractionWithNumber:[self.leftOperandLabel.text intValue] otherNumber:[self.rightOperandLabel.text intValue]];
            break;
            
        case ASWOperatorMultiplication:
            answer = [self multiplicationWithNumber:[self.leftOperandLabel.text intValue] otherNumber:[self.rightOperandLabel.text intValue]];
            break;
            
        default:
            break;
    }
    
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

- (NSInteger)integerRandomValueWithRange:(NSRange)range
{
    // arc4random_uniform(N) 함수는 0 에서 N-1 까지의 정수 난수를 생성한다.
    NSInteger returnValue = arc4random_uniform(range.length) + range.location;
    return returnValue;
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

- (NSString *)stringOperator:(ASWOperator)anOperator
{
    NSString *returnString;
    switch (anOperator) {
        case ASWOperatorAddition:
            returnString = kASWOperatorStringAddition;
            break;
            
        case ASWOperatorSubtraction:
            returnString = kASWOperatorStringSubtraction;
            break;
            
        case ASWOperatorMultiplication:
            returnString = kASWOperatorStringMultiplication;
            break;
            
        case ASWOperatorDivision:
            returnString = kASWOperatorStringDivision;
            break;
            
        default:
            returnString = nil;
            break;
    }
    return returnString;
}

@end

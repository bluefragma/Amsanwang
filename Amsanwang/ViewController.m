//
//  ViewController.m
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import "ViewController.h"

// 연산자 열거형.
typedef NS_ENUM(NSInteger, ASWOperatorState) {
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

@property (assign, nonatomic) NSRange operandRange;
@property (assign, nonatomic) NSRange operatorRange;
@property (assign, nonatomic) NSInteger leftOperandValue;
@property (assign, nonatomic) NSInteger rightOperandValue;
@property (assign, nonatomic) ASWOperatorState currentOperator;
@property (assign, nonatomic) NSInteger answer;

- (NSInteger)calculateWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber operatorState:(ASWOperatorState)operatorState;
- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)divisionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)integerRandomValueWithRange:(NSRange)range;
- (NSString *)stringOperator:(ASWOperatorState)operatorState;

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
    NSRange operandRange = NSMakeRange(1, 9);
    self.operandRange = operandRange;
    
    // 난수를 생성한다.
    NSInteger leftOperandValue = [self integerRandomValueWithRange:operandRange];
    NSInteger rightOperandValue = [self integerRandomValueWithRange:operandRange];
    self.leftOperandValue = leftOperandValue;
    self.rightOperandValue = rightOperandValue;
    
    // 연산자 선택 범위.
    NSRange operatorRange = NSMakeRange(0, 3);
    self.operatorRange = operatorRange;
    
    // 연산자 랜덤 선택.
    ASWOperatorState currentOperator = [self integerRandomValueWithRange:operatorRange];;
    self.currentOperator = currentOperator;
    
    // 예외 상황.
    // 숫자 키보드에서 음수 입력이 안되므로, 연산자가 빼기이면 왼쪽 피연산자의 값이 오른쪽 피연산자보다 크거나 같아야 함.
    // 왼쪽 피연산자의 값이 오른쪽 피연산자보다 작으면, 두 수를 바꾼다.
    if ((currentOperator == ASWOperatorSubtraction) && (leftOperandValue < rightOperandValue)) {
        // 전통적인 정수 스왑.
        NSInteger temp = leftOperandValue;
        leftOperandValue = rightOperandValue;
        rightOperandValue = temp;
        
        // 프로퍼티를 다시 할당한다.
        self.leftOperandValue = leftOperandValue;
        self.rightOperandValue = rightOperandValue;
    }
    
    // 정답을 생성한다.
    self.answer = [self calculateWithNumber:leftOperandValue otherNumber:rightOperandValue operatorState:currentOperator];
    
    // 좌우 라벨에 생성된 난수를 표시한다.
    // NSInteger 값을 NSNumber 리터럴 표현식으로 바꾸고, 다시 문자열 값으로 변경한다.
    self.leftOperandLabel.text = [@(leftOperandValue) stringValue];
    self.rightOperandLabel.text = [@(rightOperandValue) stringValue];
    
    // 연산자 라벨에 연산자 기호를 표시한다.
    self.operatorLabel.text = [self stringOperator:currentOperator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    NSInteger answer = self.answer;
    if (answer == [self.answerField.text integerValue]) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"정답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
    else {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:@"오답입니다" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alerview show];
    }
}

#pragma mark - Private

- (NSInteger)calculateWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber operatorState:(ASWOperatorState)operatorState
{
    NSInteger returnValue;
    switch (operatorState) {
        case ASWOperatorAddition:
            returnValue = [self additionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorSubtraction:
            returnValue = [self subtractionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorMultiplication:
            returnValue = [self multiplicationWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorDivision:
            returnValue = [self divisionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        default:
            break;
    }
    return returnValue;
}

- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    NSInteger returnValue = aNumber + otherNumber;
    return returnValue;
}

- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    NSInteger returnValue = aNumber - otherNumber;
    return returnValue;
}

- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    NSInteger returnValue = aNumber * otherNumber;
    return returnValue;
}

- (NSInteger)divisionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber
{
    NSInteger returnValue = aNumber / otherNumber;
    return returnValue;
}

- (NSInteger)integerRandomValueWithRange:(NSRange)range
{
    // arc4random_uniform(N) 함수는 0 에서 N-1 까지의 정수 난수를 생성한다.
    NSInteger returnValue = arc4random_uniform(range.length) + range.location;
    return returnValue;
}

- (NSString *)stringOperator:(ASWOperatorState)operatorState
{
    NSString *returnString;
    switch (operatorState) {
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

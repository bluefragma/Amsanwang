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

@property (assign, nonatomic) NSRange operandRange;
@property (assign, nonatomic) NSRange operatorRange;
@property (assign, nonatomic) NSInteger leftOperandValue;
@property (assign, nonatomic) NSInteger rightOperandValue;
@property (assign, nonatomic) ASWOperator currentOperator;
@property (assign, nonatomic) NSInteger answer;

- (NSInteger)calculateWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber operator:(ASWOperator)anOperator;
- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)divisionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber;
- (NSInteger)integerRandomValueWithRange:(NSRange)range;
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
    
    // 난수를 생성한다.
    self.leftOperandValue = [self integerRandomValueWithRange:self.operandRange];
    self.rightOperandValue = [self integerRandomValueWithRange:self.operandRange];
    
    // 좌우 라벨에 생성된 난수를 할당한다.
    // NSInteger 값을 NSNumber 리터럴 표현식으로 바꾸고, 다시 문자열 값으로 변경한다.
    self.leftOperandLabel.text = [@(self.leftOperandValue) stringValue];
    self.rightOperandLabel.text = [@(self.rightOperandValue) stringValue];
    
    // 연산자 선택 범위.
    self.operatorRange = NSMakeRange(0, 3);
    
    // 연산자 랜덤 선택.
    self.currentOperator = [self integerRandomValueWithRange:self.operatorRange];
    self.operatorLabel.text = [self stringOperator:self.currentOperator];
    
    // 정답을 생성한다.
    self.answer = [self calculateWithNumber:self.leftOperandValue otherNumber:self.rightOperandValue operator:self.currentOperator];
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

- (NSInteger)calculateWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber operator:(ASWOperator)anOperator
{
    NSInteger returnValue;
    switch (anOperator) {
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

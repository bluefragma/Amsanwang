//
//  ViewController.m
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import "ViewController.h"

// 연산자 상태 열거형.
typedef NS_ENUM(NSInteger, ASWOperatorState) {
    ASWOperatorStateAddition,
    ASWOperatorStateSubtraction,
    ASWOperatorStateMultiplication,
    ASWOperatorStateDivision
};

// 연산자 기호.
static NSString * const kASWOperatorStringAddition = @"+";
static NSString * const kASWOperatorStringSubtraction = @"−";
static NSString * const kASWOperatorStringMultiplication = @"×";
static NSString * const kASWOperatorStringDivision = @"÷";

@interface ViewController ()

@property (assign, nonatomic) NSInteger leftOperandValue;
@property (assign, nonatomic) NSInteger rightOperandValue;
@property (assign, nonatomic) ASWOperatorState operatorState;
@property (assign, nonatomic) NSInteger answer;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 난수를 생성한다.
    u_int32_t from = 1;
    u_int32_t to = 9;
    NSInteger leftOperandValue = [self integerRandomValueFrom:from to:to];
    NSInteger rightOperandValue = [self integerRandomValueFrom:from to:to];
    self.leftOperandValue = leftOperandValue;
    self.rightOperandValue = rightOperandValue;
    
    // 연산자 랜덤 선택.
    ASWOperatorState operatorState = [self integerRandomValueFrom:ASWOperatorStateAddition to:ASWOperatorStateMultiplication];
    self.operatorState = operatorState;
    
    // 예외 상황.
    // 숫자 키보드에서 음수 입력이 안되므로, 연산자가 빼기이면 왼쪽 피연산자의 값이 오른쪽 피연산자보다 크거나 같아야 함.
    // 왼쪽 피연산자의 값이 오른쪽 피연산자보다 작으면, 두 수를 바꾼다.
    if ((operatorState == ASWOperatorStateSubtraction) && (leftOperandValue < rightOperandValue)) {
        // 전통적인 정수 스왑.
        NSInteger temp = leftOperandValue;
        leftOperandValue = rightOperandValue;
        rightOperandValue = temp;
        
        // 프로퍼티를 다시 할당한다.
        self.leftOperandValue = leftOperandValue;
        self.rightOperandValue = rightOperandValue;
    }
    
    // 정답을 생성한다.
    self.answer = [self calculateWithNumber:leftOperandValue otherNumber:rightOperandValue operatorState:operatorState];
    
    // 좌우 라벨에 생성된 난수를 표시한다.
    // NSInteger 값을 NSNumber 리터럴 표현식으로 바꾸고, 다시 문자열 값으로 변경한다.
    self.leftOperandLabel.text = [@(leftOperandValue) stringValue];
    self.rightOperandLabel.text = [@(rightOperandValue) stringValue];
    
    // 연산자 라벨에 연산자 기호를 표시한다.
    self.operatorLabel.text = [self operatorSign:operatorState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

/*! 입력된 값을 정답과 비교하여 정답 여부를 표시한다.
 
 @param sender 이 액션을 보낸 객체.
 */
- (IBAction)done:(id)sender {
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

/*! 지정된 범위의 정수형 난수를 생성한다.
 Example usage:
 @code
 u_int32_t from = 1;
 u_int32_t to = 9;
 NSInteger randomNumber = [self integerRandomValueFrom:from to:to];
 @endcode
 
 @param from 범위의 시작.
 @param to 범위의 끝.
 */
- (NSInteger)integerRandomValueFrom:(u_int32_t)from to:(u_int32_t)to {
    u_int32_t number = to - from + 1;
    // arc4random_uniform(N) 함수는 0 에서 N-1 까지의 정수 난수를 생성한다.
    NSInteger returnValue = arc4random_uniform(number) + from;
    return returnValue;
}

/*! 두 숫자를 더한다.
 Example usage:
 @code
 NSInteger aNumber = 1;
 NSInteger otherNumber = 2;
 NSInteger result = [self additionWithNumber:aNumber otherNumber:otherNumber];
 @endcode
 
 @param aNumber 한 숫자.
 @param otherNumber 다른 숫자.
 */
- (NSInteger)additionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber {
    NSInteger returnValue = aNumber + otherNumber;
    return returnValue;
}

/*! 한 숫자에서 다른 숫자를 뺀다.
 Example usage:
 @code
 NSInteger aNumber = 2;
 NSInteger otherNumber = 1;
 NSInteger result = [self subtractionWithNumber:aNumber otherNumber:otherNumber];
 @endcode
 
 @param aNumber 한 숫자.
 @param otherNumber 다른 숫자.
 */
- (NSInteger)subtractionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber {
    NSInteger returnValue = aNumber - otherNumber;
    return returnValue;
}

/*! 두 숫자를 곱한다.
 Example usage:
 @code
 NSInteger aNumber = 2;
 NSInteger otherNumber = 2;
 NSInteger result = [self multiplicationWithNumber:aNumber otherNumber:otherNumber];
 @endcode
 
 @param aNumber 한 숫자.
 @param otherNumber 다른 숫자.
 */
- (NSInteger)multiplicationWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber {
    NSInteger returnValue = aNumber * otherNumber;
    return returnValue;
}

/*! 한 숫자를 다른 숫자로 나눈다.
 Example usage:
 @code
 NSInteger aNumber = 4;
 NSInteger otherNumber = 2;
 NSInteger result = [self divisionWithNumber:aNumber otherNumber:otherNumber];
 @endcode
 
 @param aNumber 한 숫자.
 @param otherNumber 다른 숫자.
 */
- (NSInteger)divisionWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber {
    NSInteger returnValue = aNumber / otherNumber;
    return returnValue;
}

/*! 두 숫자를 연산자 상태에 따라 계산한다.
 Example usage:
 @code
 NSInteger aNumber = 4;
 NSInteger otherNumber = 2;
 NSInteger result = [self calculateWithNumber:aNumber otherNumber:otherNumber operatorState:ASWOperatorStateAddition];
 @endcode
 
 @param aNumber 한 숫자.
 @param otherNumber 다른 숫자.
 @param operatorState 연산자 상태.
 */
- (NSInteger)calculateWithNumber:(NSInteger)aNumber otherNumber:(NSInteger)otherNumber operatorState:(ASWOperatorState)operatorState {
    NSInteger returnValue;
    switch (operatorState) {
        case ASWOperatorStateAddition:
            returnValue = [self additionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorStateSubtraction:
            returnValue = [self subtractionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorStateMultiplication:
            returnValue = [self multiplicationWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        case ASWOperatorStateDivision:
            returnValue = [self divisionWithNumber:aNumber otherNumber:otherNumber];
            break;
            
        default:
            break;
    }
    return returnValue;
}

/*! 연산자 상태에 해당하는 연산자 기호를 구한다.
 Example usage:
 @code
 NSString *operatorSign = [self operatorSign:ASWOperatorStateAddition];
 @endcode
 
 @param operatorState 연산자 상태.
 */
- (NSString *)operatorSign:(ASWOperatorState)operatorState {
    NSString *returnString;
    switch (operatorState) {
        case ASWOperatorStateAddition:
            returnString = kASWOperatorStringAddition;
            break;
            
        case ASWOperatorStateSubtraction:
            returnString = kASWOperatorStringSubtraction;
            break;
            
        case ASWOperatorStateMultiplication:
            returnString = kASWOperatorStringMultiplication;
            break;
            
        case ASWOperatorStateDivision:
            returnString = kASWOperatorStringDivision;
            break;
            
        default:
            returnString = nil;
            break;
    }
    return returnString;
}

@end

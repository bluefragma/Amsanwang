//
//  ViewController.h
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *leftOperandLabel;     // 좌측 피연산자 라벨
@property (weak, nonatomic) IBOutlet UILabel *rightOperandLabel;    // 우측 피연산자 라벨
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;        // 연산자 라벨
@property (weak, nonatomic) IBOutlet UITextField *answerField;      // 응답 필드

- (IBAction)done:(id)sender;    // 확인 버튼

@end

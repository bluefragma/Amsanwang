//
//  ViewController.h
//  Amsanwang
//
//  Created by Jeongyeon Park on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *leftOperandLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightOperandLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerField;

- (IBAction)done:(id)sender;

@end

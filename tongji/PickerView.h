//
//  PickerView.h
//  tongji
//
//  Created by 张鹏 on 2018/5/19.
//  Copyright © 2018年 c4ibD3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickerView;
typedef void (^SureBlock)(PickerView *picker, NSInteger selectedIndex,id selectedValue);
typedef void (^CancelBlock)(PickerView *picker);

@interface PickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIPickerView *dataPickerView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITapGestureRecognizer *recognizer;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) SureBlock sureBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;
+(void)showDataArray:(NSArray *)array title:(NSString *)titleStr completedHandle:(SureBlock)complete;

@end

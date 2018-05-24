//
//  PickerView.m
//  tongji
//
//  Created by 张鹏 on 2018/5/19.
//  Copyright © 2018年 c4ibD3. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView
- (IBAction)cancelButtonAction:(id)sender {
    
    [self disMissPickView];
}
- (IBAction)doneButtonAction:(id)sender {
    id selectedValue = self.dataArray[[self.dataPickerView selectedRowInComponent:0]];
    if (self.sureBlock) {
        self.sureBlock(self,[self.dataPickerView selectedRowInComponent:0],selectedValue);
    }
    [self disMissPickView];
}

- (void)configuraView{
    [self.dataPickerView reloadAllComponents];
    self.recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissPickView)];
    if (self.backView != nil) {
        [self.backView removeFromSuperview];
    }
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.backView addGestureRecognizer:self.recognizer];
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 185);
    [self.backView addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -185, [UIScreen mainScreen].bounds.size.width, 185);
    }];
    
}
-(void)disMissPickView{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.backView.frame.size.height, self.backView.frame.size.width, 185);
    } completion:^(BOOL finished) {
        [self.backView removeGestureRecognizer:self.recognizer];
        [self.backView removeFromSuperview];
    }];
}

+(void)showDataArray:(NSArray *)array title:(NSString *)titleStr completedHandle:(SureBlock)complete{
    PickerView *pickerView = [[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil].firstObject;
    pickerView.dataArray = array;
    pickerView.titleLabel.text = titleStr;
    pickerView.sureBlock = complete;
    [pickerView configuraView];
}
#pragma mark - PickerView
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 45.0;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc]init];
        pickerLabel.minimumFontSize = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setTextColor:[UIColor blackColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:25]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end

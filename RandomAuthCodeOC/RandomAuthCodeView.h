//
//  RandomAuthCodeView.h
//  RandomAuthCode
//
//  Created by haohao on 16/10/19.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SendCodeMessageBlock)(NSString *codeMessageStr);
@interface RandomAuthCodeView : UIView
@property (nonatomic, copy) SendCodeMessageBlock sendCodeMessageBlock;
//类方法创建
-(RandomAuthCodeView *)sharedRandomAuthCodeViewWithFrame:(CGRect)frame;
@end

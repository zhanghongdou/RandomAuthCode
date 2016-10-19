//
//  RandomAuthCodeView.m
//  RandomAuthCode
//
//  Created by haohao on 16/10/19.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "RandomAuthCodeView.h"
#define CODECOUNT 4
@interface RandomAuthCodeView ()
{
    //默认的数组
    NSArray *_codeMessageArray;
    NSMutableString *_codeString;
}
@end
@implementation RandomAuthCodeView

//MARK: ----- init
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置数据源信息
        [self setDataArray];
        [self setRandomAuthCodeViewBackGroundColor];
        [self setRandomAuthCodeMessage];
        [self setTapGestureToModifyCodeMessage];
    }
    return self;
}

-(void)setDataArray
{
    _codeMessageArray = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
}

//MARK: ------ 兼容xib，故事版搭建
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setDataArray];
        [self setRandomAuthCodeViewBackGroundColor];
        [self setRandomAuthCodeMessage];
        [self setTapGestureToModifyCodeMessage];
    }
    return self;
}

//MARK: ------ 类方法创建
-(RandomAuthCodeView *)sharedRandomAuthCodeViewWithFrame:(CGRect)frame
{
    return [[RandomAuthCodeView alloc]initWithFrame:frame];
}

//MARK: ------ 设置界面背景色
-(void)setRandomAuthCodeViewBackGroundColor
{
    //设置色调
    float hue = arc4random() % 360;
    UIColor *color = [UIColor colorWithHue:1.0 * hue / 360.0
                       saturation:1.0
                       brightness:1.0
                            alpha:0.5];
    self.backgroundColor = color;
}

//MARK: ------ 设置验证码信息
-(void)setRandomAuthCodeMessage
{
    [self showCodeMessage];
}

//MARk ------- 添加手势
-(void)setTapGestureToModifyCodeMessage
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelector:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

-(void)tapSelector:(UITapGestureRecognizer *)sender
{
    [self setRandomAuthCodeViewBackGroundColor];
    [self showCodeMessage];
    //开始绘图
    [self setNeedsDisplay];
}

-(void)showCodeMessage
{
    _codeString = [[NSMutableString alloc]initWithCapacity:CODECOUNT];
    for (int i = 0; i < CODECOUNT; i++) {
        NSString *str = _codeMessageArray[arc4random() % (_codeMessageArray.count - 1)];
        [_codeString appendString:str];
    }
    if (self.sendCodeMessageBlock) {
        self.sendCodeMessageBlock(_codeString);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.sendCodeMessageBlock) {
        self.sendCodeMessageBlock(_codeString);
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize charSize = [@"A" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    int width = rect.size.width / _codeString.length - charSize.width;
    int height = rect.size.height - charSize.height;
    CGPoint point;
    float pX,pY;
    for (int i = 0; i < _codeString.length; i++)
    {
        pX = arc4random() % width + rect.size.width / _codeString.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [_codeString characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    }
    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置背景线的宽度
    CGContextSetLineWidth(context, 1.0);
    //绘制8根背景线
    for (int i = 0; i < 8; i++) {
        float hue = arc4random() % 360;
        UIColor *color = [UIColor colorWithHue:1.0 * hue / 360.0
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:0.5];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}


@end

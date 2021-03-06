//
//  answer_draw.m
//  one-stroke_sketch
//
//  Created by Shin,ichi  Uehara on 2013/12/05.
//  Copyright (c) 2013年 Shin,ichi  Uehara. All rights reserved.
//

#import "answer_draw.h"
#import "Line.h"
#import "AppDelegate.h"

@implementation answer_draw{
    
    AppDelegate *appDelegate;
    CGPoint _point;
    
    int count_line;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    count_line = 0;
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    
    //lines配列からひとつの線を取り出す
    for(Line *line in self.lines) {
        
        
        // 直線を描画
        CGContextRef context = UIGraphicsGetCurrentContext();  // コンテキストを取得
        CGContextMoveToPoint(context, line.s_point.x,line.s_point.y);  // 始点
        CGContextAddLineToPoint(context, line.e_point.x ,line.e_point.y);  // 終点
        
        // 線の太さを指定
        CGContextSetLineWidth(context, line.lineWidth);  // 12ptに設定
        
        // 終端の形を指定
        CGContextSetLineCap(context, kCGLineCapRound);  // 丸に設定
        
        CGContextSetStrokeColorWithColor(context, [line.color CGColor]);
        
        CGContextStrokePath(context);  // 描画！
        
        }
    
}


@end

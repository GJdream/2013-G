//
//  drawViewController.m
//  one-stroke_sketch
//
//  Created by Shin,ichi  Uehara on 2013/12/04.
//  Copyright (c) 2013年 Shin,ichi  Uehara. All rights reserved.
//


//タップ検出して座標などを渡すクラス


#import "drawViewController.h"
#import "answer_draw.h"
#import "Line.h"
#import "question_draw.h"
#import "AppDelegate.h" //AppDelegateにある値をグローバル関数に様に使う（あまり良い方法でない）

@interface drawViewController (){
    
    //線を管理する配列
    NSMutableArray *_lines;
    //1本の線
    Line *_line;
    //線色
    UIColor *_lineColor;
    //線の幅
    float _linewidth;
    
    //NSMutableArray *_check;
    
    AppDelegate *appDelegate;   //線のデータを読み込むためのappDelegate
    
    int i;  //connectの番号
    
    
}

@end

@implementation drawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //線を格納する配列を生成
    _lines = [[NSMutableArray alloc]init];
    
    //背景色を白に設定
    self.view.backgroundColor = [UIColor whiteColor];
    
    //デフォルトの線の色を青に
    _lineColor = [UIColor blueColor];
    
    //線幅を12に設定
    _linewidth = 12.0;
    
    //グローバル変数のように使う
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //現在の座標を取得
    CGPoint p = [[touches anyObject] locationInView:self.view];
    
    
    for(NSValue *data in appDelegate.Datas){
    
        CGPoint _point = [data CGPointValue];
        
        //座標が点の中であれば描画スタート
        if(CGRectContainsPoint(CGRectMake(_point.x-10,_point.y-10,25,25),p)){
    
            
            _line.e_point = _point;
        
            ((answer_draw *)(self.view)).lines = _lines;
    
            //１つの線を格納するオブジェクトを生成
            _line = [[Line alloc]init];
            _line.color = _lineColor;
            _line.lineWidth = _linewidth;
            _line.points = [[NSMutableArray alloc]init];
            _line.able_draw = NO;
    
            //*front_point = _point;
            
            //線を配列「_lines」に格納
            [_lines addObject:_line];
    
            _line.s_point = _point;
    
        }
        
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //現在のポイントを線に追加
    CGPoint p = [[touches anyObject] locationInView:self.view];
    _line.e_point = p;
    
    //始点が点の位置以外にならようにする
    _line.able_draw = YES;
    
    //iをリセット
    i = 0;
    
    //点をタッチした際の処理（点以外の場所では処理しない）
    //受け取った点の座標を全部回す
    //線がつながっていないところには引けない
    for(NSValue *data in appDelegate.Datas){
        
        CGPoint _point = [data CGPointValue];
        
        
        //dataの点とつながっている点を_connectに
        for(NSValue *_connect in [appDelegate.Connect_num objectAtIndex:i]){
        
            
            //もしタップしている座標が点の上ならば新しい線を描画
            if(CGRectContainsPoint(CGRectMake(_point.x-10,_point.y-10,25,25),p) && CGPointEqualToPoint(_line.s_point, [_connect CGPointValue])
){
                
                _line.e_point = _point;
                
                ((answer_draw *)(self.view)).lines = _lines;
                
                //１つの線を格納するオブジェクトを生成
                _line = [[Line alloc]init];
                _line.color = _lineColor;
                _line.lineWidth = _linewidth;
                _line.points = [[NSMutableArray alloc]init];
                _line.able_draw = NO;
                
                //線を配列「_lines」に格納
                [_lines addObject:_line];
                
                _line.s_point = _point;
                
            }
        }
        i += 1;
    }
    
    

    //viewを書き換える
    if(_line.able_draw)
        [self.view setNeedsDisplay];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//各ボタンの機能
//今無し
- (IBAction)seikaibtn:(id)sender {
    [self.view bringSubviewToFront:_q_continue];
}


//今無し
- (IBAction)nextbtn:(id)sender {
    [self.view sendSubviewToBack:_q_continue];
}


//線を全て消去
- (IBAction)clearImage:(id)sender {
    
    [_lines removeAllObjects];
    [self.view setNeedsDisplay];
}



@end

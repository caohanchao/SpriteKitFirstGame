//
//  GameViewController.m
//  SpriteKitSimpleGame
//
//  Created by caohanchao on 2017/3/8.
//  Copyright © 2017年 chc. All rights reserved.
//

#import "GameViewController.h"
//#import "GameScene.h"
#import "MyScene.h"
#import "SKMainScene.h"
@interface GameViewController ()

@property (nonatomic,strong)SKView *skView;
@property (nonatomic,strong)UILabel *lb_score;
@property (nonatomic,strong)UIButton *btn_strat;

@end

@implementation GameViewController

- (SKView *)skView {
    if (!_skView) {
        _skView = [[SKView alloc] initWithFrame:self.view.bounds];
        _skView.showsFPS = YES;
        _skView.showsNodeCount = YES;
    }
    return _skView;
}

- (UILabel *)lb_score {
    if (!_lb_score) {
        _lb_score = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
        _lb_score.text = @"分数：0";
        _lb_score.font = [UIFont systemFontOfSize:15];
        _lb_score.textAlignment = NSTextAlignmentCenter;
        _lb_score.textColor = [UIColor colorWithRed:0.91 green:0.22 blue:0.10 alpha:1.00];
    }return _lb_score;
}

- (UIButton *)btn_strat {
    if (!_btn_strat) {
        _btn_strat = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_strat.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
        [_btn_strat setBackgroundColor:[UIColor blackColor]];
        [_btn_strat setTitle:@"开始游戏" forState:0];
        [_btn_strat addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
        [_skView addSubview:_btn_strat];
    }
    return _btn_strat;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    [self initAll];
//    [self btn_strat];
}

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
*/
    
    
    [self initAll];
    
    
}

- (void)initAll {
    [self.view addSubview:self.skView];
    
    //Create and configure the scene
    SKScene *scene = [SKMainScene sceneWithSize:self.skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.skView presentScene:scene];
    
    UIImage *image = [UIImage imageNamed:@"BurstAircraftPause"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 25, image.size.width,image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:@"gameOverNotification" object:nil];
    
    
}

- (void)gameOver{
    
    UIView *backgroundView =  [[UIView alloc]initWithFrame:self.view.bounds];
    
    UIButton *button = [[UIButton alloc]init];
    [button setBounds:CGRectMake(0,0,200,30)];
    [button setCenter:backgroundView.center];
    [button setTitle:@"重新开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setBorderWidth:2.0];
    [button.layer setCornerRadius:15.0];
    [button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:button];
    [backgroundView setCenter:self.view.center];
    
    [self.view addSubview:backgroundView];
}

- (void)pause{
    
    ((SKView *)self.view).paused = YES;
    
    UIView *pauseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    
    UIButton *button1 = [[UIButton alloc]init];
    [button1 setFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100,50,200,30)];
    [button1 setTitle:@"继续" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1.layer setBorderWidth:2.0];
    [button1.layer setCornerRadius:15.0];
    [button1.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button1 addTarget:self action:@selector(continueGame:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]init];
    [button2 setFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100,100,200,30)];
    [button2 setTitle:@"重新开始" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2.layer setBorderWidth:2.0];
    [button2.layer setCornerRadius:15.0];
    [button2.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button2 addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button2];
    
    pauseView.center = self.view.center;
    
    [self.view addSubview:pauseView];
    
}

- (void)restart:(UIButton *)button{
    [button.superview removeFromSuperview];
    ((SKView *)self.view).paused = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"restartNotification" object:nil];
}

- (void)continueGame:(UIButton *)button{
    [button.superview removeFromSuperview];
    ((SKView *)self.view).paused = NO;
}

//-(void)start:(UIButton *)btn
//{
////    [btn removeFromSuperview];
//    [btn setHidden:YES];
//    [self.skView addSubview:self.lb_score];
//    
//    MyScene * scene = [MyScene sceneWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
//    //scene.scaleMode = SKSceneScaleModeAspectFill;
////    scene.overDelegate = self;
//    _lb_score.text = @"分数：0";
//    // Present the scene.
//    [_skView presentScene:scene];
//}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

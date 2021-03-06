//
//  SHSelectColorViewController.m
//  G4Image
//
//  Created by LHY on 2017/4/27.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import "SHSelectColorViewController.h"
#import "SHColorWheelView.h"

@interface SHSelectColorViewController () <SHColorWheelViewDelegate>

/// 取色计
@property (nonatomic, strong) SHColorWheelView *colorView;

/// 显示颜色的view
@property (nonatomic, strong) UIView *showColorView;

/// cell上显示的颜色
@property (nonatomic, strong) UIView *cellColorView;

/// 保存颜色的按钮
@property (nonatomic, strong) SHButton *saveColorButton;


@end

@implementation SHSelectColorViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.colorView.bounds = CGRectMake(0, 0, self.view.frame_width, self.view.frame_width);
    self.colorView.center = self.view.center;
    
    // 在重绘制图片 -- 触发系统重新绘制 drawRect
    [self.colorView setNeedsDisplayInRect:self.colorView.bounds];
    
    // 布局颜色指示器
    self.showColorView.frame_x = 0;
    self.showColorView.frame_width = self.view.frame_width;
    self.showColorView.frame_y = self.view.frame_height - SHTabBarHeight;
    self.showColorView.frame_height = SHTabBarHeight;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SHGlobalBackgroundColor;
    
    [self.view addSubview:self.colorView];
    [self.view addSubview:self.showColorView];
    
    // 增加一个关闭按钮
    UIButton *button = [UIButton buttonWithImageName:@"close" hightlightedImageName:nil addTarget:self action:@selector(closeColorView)];
    [self.view addSubview:button];
    
    button.frame = CGRectMake(SHStatusHeight, SHStatusHeight, SHNavigationBarHeight, SHNavigationBarHeight);
}

- (void)closeColorView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 实现这个代理是为了方便发送数据
- (void)setZonesColorData:(NSData *)colorData recognizer:(UIGestureRecognizer *)recognizer {
    
    // 获得当前的按钮
    
    Byte *colorValue = (Byte *)[colorData bytes];
    
    // 发送LED指令
    Byte red = colorValue[0] * 100 / 255.0;
    Byte green = colorValue[1] * 100 / 255.0 ;
    Byte blue = colorValue[2] * 100 / 255.0 ;
    Byte alpha = colorValue[3] * 100 / 255.0;
    
    UIColor *color = [UIColor colorWithRed:red/100.0 green:green/100.0 blue:blue/100.0 alpha:alpha/100.0];
    self.showColorView.backgroundColor = color;
    self.cellColorView.backgroundColor = color;
    
    // 记录颜色
    self.saveColorButton.buttonPara1 = red;
    self.saveColorButton.buttonPara2 = green;
    self.saveColorButton.buttonPara3 = blue;
    self.saveColorButton.buttonPara4 = alpha;
    
    // 手势结束才发
    if (recognizer.state == UIGestureRecognizerStateEnded) {
    
        [SHSendDeviceData setLedColor:self.saveColorButton
         ];
    }
}

- (void)show:(SHButton *)deviceButton colorView:(UIView *)colorView {
    
    self.saveColorButton = deviceButton;
    self.cellColorView = colorView;
    
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    
    // 弹出
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

/// 显示颜色指示条
- (UIView *)showColorView {

    if (!_showColorView) {
        _showColorView = [[UIView alloc] init];
    }
    return _showColorView;
}

/// 取色计
- (SHColorWheelView *)colorView {
    
    if (!_colorView) {
        _colorView = [[SHColorWheelView alloc] init];
        _colorView.delegate = self;
    }
    return _colorView;
}

@end

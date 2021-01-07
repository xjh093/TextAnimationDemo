//
//  ViewController.m
//  AYTextAnimationDemo
//
//  Created by wpsd on 2017/2/4.
//  Copyright © 2017年 wpsd. All rights reserved.
//

#import "ViewController.h"
#import "FontCell.h"
#import "CALayer+AYTextAnimationExtension.h"

#define kMainWidth [UIScreen mainScreen].bounds.size.width
#define kMainHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,  strong) UITableView *tableView;
@property (nonatomic,  strong) NSMutableArray *dataArray;
@property (nonatomic,  strong) UISlider *slider;

@property (strong, nonatomic) CALayer *animationLayer;
@property (strong, nonatomic) CAShapeLayer *pathLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animationLayer = [CALayer layer];
    _animationLayer.frame = CGRectMake(30, 100, CGRectGetWidth(self.view.bounds) - 60, 50);
    _animationLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    [self.view.layer addSublayer:_animationLayer];
    
    _pathLayer = [_animationLayer setupAnimationTextLayerWithText:@"C'est La Vie 阿妹惊~" fontSize:32 fontColor:[UIColor redColor]];
    [self setupSlider];
    
    
    _dataArray = @[].mutableCopy;
#if 1
    _dataArray = [self allFonts];
#else
    _dataArray = [self someFonts];
#endif
    
    self.navigationItem.title = [NSString stringWithFormat:@"iOS %@ 字体 %@ 个",[UIDevice currentDevice].systemVersion, @(_dataArray.count)];
    
    [self.view addSubview:self.tableView];
}

#pragma mark -------------------------------------视图-------------------------------------------

- (void)setupSlider
{
    CGFloat leftMargin = 50;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(_animationLayer.frame) + 30, kMainWidth - leftMargin * 2, 3)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    _slider = slider;
}

#pragma mark -------------------------------------事件-------------------------------------------

- (NSMutableArray *)allFonts
{
    NSMutableArray *data = @[].mutableCopy;
    
    NSArray *fonts = [UIFont familyNames];
    for (NSString *font in fonts) {
        NSArray *all = [UIFont fontNamesForFamilyName:font];
        [data addObjectsFromArray:all];
    }
    
    return data;
}

- (NSMutableArray *)someFonts
{
    return @[@"AppleSDGothicNeo-Thin",
             @"AppleSDGothicNeo-UltraLight",
             @"AvenirNextCondensed-UltraLightItalic",
             @"AvenirNextCondensed-UltraLight",
             @"HelveticaNeue-UltraLightItalic",
             @"HelveticaNeue-UltraLight",
             @"HelveticaNeue-ThinItalic",
             @"HelveticaNeue-Thin",
             @"PingFangTC-Thin",
             @"PingFangTC-Ultralight",
             @"PingFangHK-Thin",
             @"AvenirNext-UltraLightItalic",
             @"AvenirNext-UltraLight",
             @"PingFangSC-Ultralight",].mutableCopy;
}

#pragma mark ---UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"resueID";
    FontCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FontCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSString *fontName = _dataArray[indexPath.row];
    [cell configWith:@"123-abc-ABC-系统字体长这样~么么哒" fontName:fontName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *fontName = _dataArray[indexPath.row];
    [UIPasteboard generalPasteboard].string = fontName;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"字体已复制到粘贴板" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sliderValueChanged:(UISlider *)sender {
    self.pathLayer.strokeEnd = sender.value;
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat y = CGRectGetMaxY(self.slider.frame) + 20;
        CGRect frame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-y-30);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 80;
        tableView.tableFooterView = [[UIView alloc] init];
        _tableView = tableView;
    }
    return _tableView;
}

@end

/* iOS 13.7 以下字体画出来，不是空心的
 AppleSDGothicNeo-Thin
 AppleSDGothicNeo-UltraLight
 AvenirNextCondensed-UltraLightItalic
 AvenirNextCondensed-UltraLight
 HelveticaNeue-UltraLightItalic
 HelveticaNeue-UltraLight
 HelveticaNeue-ThinItalic
 HelveticaNeue-Thin
 PingFangTC-Thin
 PingFangTC-Ultralight
 PingFangHK-Thin
 AvenirNext-UltraLightItalic
 AvenirNext-UltraLight
 PingFangSC-Ultralight
 */


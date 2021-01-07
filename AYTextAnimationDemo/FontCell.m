//
//  FontCell.m
//  AllFonts
//
//  Created by HaoCold on 2021/1/7.
//

#import "FontCell.h"
#import "CALayer+AYTextAnimationExtension.h"

#define kMainWidth [UIScreen mainScreen].bounds.size.width

@interface FontCell()
@property (nonatomic,  strong) CALayer *fontLayer;
@property (nonatomic,  strong) UILabel *fontLabel;
@end

@implementation FontCell

#pragma mark -------------------------------------视图-------------------------------------------

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self xjh_setupViews];
    }
    return self;
}

- (void)xjh_setupViews
{
    [self.contentView.layer addSublayer:self.fontLayer];
    [self.contentView addSubview:self.fontLabel];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.fontLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

#pragma mark -------------------------------------事件-------------------------------------------

- (void)configWith:(NSString *)text fontName:(NSString *)fontName
{
    _fontLabel.text = fontName;
    CAShapeLayer *layer = [_fontLayer setupAnimationTextLayerWithText:text fontSize:20 fontName:fontName fontColor:[UIColor orangeColor]];
    layer.strokeEnd = 1;
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (CALayer *)fontLayer{
    if (!_fontLayer) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(15, 10, kMainWidth-30, 40);
        layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        _fontLayer = layer;
    }
    return _fontLayer;
}

- (UILabel *)fontLabel{
    if (!_fontLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 55, kMainWidth-30, 20);
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        _fontLabel = label;
    }
    return _fontLabel;
}
@end

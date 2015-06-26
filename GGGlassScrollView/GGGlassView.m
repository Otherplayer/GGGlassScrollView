//
//  GGGlassView.m
//  
//
//  Created by __无邪_ on 15/6/16.
//
//

#import "GGGlassView.h"

#define DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL 30
#define DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL 150


@interface GGGlassView ()
@property (nonatomic, strong) UIImage *backgroundImage;

@end


@implementation GGGlassView{
    UIScrollView *_backgroundScrollView;
    UIView *_constraitView; // for autolayout
    UIImageView *_backgroundImageView;
    
}

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage{
    self = [super initWithFrame:frame];
    if (self) {
        //initialize values
        _backgroundImage = backgroundImage;
        //create views
        [self createBackgroundView];
    }
    return self;
}

#pragma mark - Public Functions

- (void)scrollHorizontalRatio:(CGFloat)ratio{
    // when the view scroll horizontally, this works the parallax magic
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL + ratio * DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, _backgroundScrollView.contentOffset.y)];
}


#pragma mark - Views creation
#pragma mark ScrollViews

- (void)createBackgroundView{
    //background
    _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [_backgroundScrollView setUserInteractionEnabled:NO];
    [_backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    [_backgroundScrollView setContentOffset:CGPointMake(DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0)];
    [self addSubview:_backgroundScrollView];
    
    _constraitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width + 2*DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL)];
    [_backgroundScrollView addSubview:_constraitView];
    
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:_backgroundImage];
    [_backgroundImageView setContentMode:UIViewContentModeScaleToFill];
    [_backgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_constraitView addSubview:_backgroundImageView];
    
    [_constraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundImageView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_backgroundImageView)]];
    [_constraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundImageView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_backgroundImageView)]];
}




@end

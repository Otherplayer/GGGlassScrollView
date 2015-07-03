//
//  GGGlassScrollView.m
//  
//
//  Created by __无邪_ on 15/6/16.
//
//

#import "GGGlassScrollView.h"
#import "GGGlassView.h"

const CGFloat BlackSideBarWidth = 2;
#define kGlassViewStartTag 666

@interface GGGlassScrollView ()<UIScrollViewAccessibilityDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *goButton;
@end

@implementation GGGlassScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createScrollView];
        self.items = [[NSArray alloc] init];
    }
    return self;
}


-(void)setItems:(NSMutableArray *)items{
    _items = items;
    
    CGFloat width = self.frame.size.width + 2*BlackSideBarWidth;
    CGFloat screenWidth = self.frame.size.width;
    
    [self.scrollView setContentSize:CGSizeMake(width * items.count, self.frame.size.height)];
    
    for (int i = 0; i < items.count; i++) {
        
        NSString *imageName = items[i];
        GGGlassView *glassView = [[GGGlassView alloc] initWithFrame:CGRectMake(width * i, 0, screenWidth, self.frame.size.height) backgroundImage:[UIImage imageNamed:imageName]];
        [glassView setTag:kGlassViewStartTag + i];
        [self.scrollView addSubview:glassView];
    }
    
    [self.goButton setFrame:CGRectMake(width * (items.count - 1) + 20, CGRectGetHeight(self.bounds) - 100, CGRectGetWidth(self.bounds) - 40, 44)];
    
}





- (void)createScrollView{
    
    CGFloat width = self.frame.size.width + 2*BlackSideBarWidth;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
    [self.scrollView setDelegate:self];
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    [self.scrollView setPagingEnabled:YES];
    [self addSubview:self.scrollView];
    
    self.goButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 100, self.frame.size.width - 40, 44)];
    [self.scrollView addSubview:self.goButton];
    [self.goButton setBackgroundColor:[UIColor redColor]];
    [self.goButton setTitle:@"Go~~~~" forState:UIControlStateNormal];
    [self.scrollView bringSubviewToFront:self.goButton];
    [self.goButton setAlpha:0];
    [self.goButton addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
    
}



#pragma mark - UIScrollViewAccessibilityDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
    int _page = (int)floor(ratio);
    NSLog(@"%i===%f",_page,ratio);
    
    [UIView animateWithDuration:0.75 animations:^{
        if (_page > self.items.count - 2) {
            [self.scrollView bringSubviewToFront:self.goButton];
            [self.goButton setAlpha:0.7];
        }else{
            [self.goButton setAlpha:0];
        }
     }];
    
    
    if ((ratio > (_page - 1)) && (ratio < (_page + 1))) {
        GGGlassView *glassView = (GGGlassView *)[self viewWithTag:kGlassViewStartTag + _page];
        [glassView scrollHorizontalRatio:-ratio + _page];
    }
    
    if ((ratio > (_page)) && (ratio < (_page + 2))) {
        GGGlassView *glassView = (GGGlassView *)[self viewWithTag:kGlassViewStartTag + _page + 1];
        [glassView scrollHorizontalRatio:-ratio + _page + 1];
    }
    
    if ((ratio > (_page + 1)) && (ratio < (_page + 3))) {
        GGGlassView *glassView = (GGGlassView *)[self viewWithTag:kGlassViewStartTag + _page + 2];
        [glassView scrollHorizontalRatio:-ratio + _page + 2];
    }
    
}


#pragma mark - Action

- (void)goAction:(id)sender{
    if (self.clickedBlock) {
        self.clickedBlock();
    }
}



@end

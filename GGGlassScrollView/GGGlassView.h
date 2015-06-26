//
//  GGGlassView.h
//  
//
//  Created by __无邪_ on 15/6/16.
//
//

#import <UIKit/UIKit.h>

@interface GGGlassView : UIView
- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage;
- (void)scrollHorizontalRatio:(CGFloat)ratio;

@end

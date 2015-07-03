//
//  GGGlassScrollView.h
//  
//
//  Created by __无邪_ on 15/6/16.
//
//

#import <UIKit/UIKit.h>

@interface GGGlassScrollView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong, setter = didClickedBlock:) void(^clickedBlock)();

@end

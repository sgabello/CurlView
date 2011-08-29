//
//  CurlView.h
//  test
//
//  Created by Andrea Ottolina on 28/08/2011.
//  Copyright 2011 Pixelinlove ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CurlView : UIView

- (id)initWithImage:(UIImage*)image curlStartAngle:(float)aStartAngle curlEndAngle:(float)aEndAngle;
- (void)reset;
- (void)animate;

@end

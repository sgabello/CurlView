//
//  CurlView.m
//
//  Created by Andrea Ottolina on 28/08/2011.
//  Copyright 2011 Pixelinlove ltd. All rights reserved.
//

#import "CurlView.h"

#define	kDuration	0.4
#define kTiming		kCAMediaTimingFunctionEaseInEaseOut

@interface CurlView ()

@property (nonatomic, retain) UIImage *curlImage;
@property (nonatomic) float startAngle;
@property (nonatomic) float endAngle;

@property (nonatomic, retain) CALayer *curlBackLayer;
@property (nonatomic, retain) CALayer *maskBackLayer;
@property (nonatomic, retain) CALayer *curlLayer;
@property (nonatomic, retain) CALayer *maskCurlLayer;

@end

@implementation CurlView

@synthesize curlImage, startAngle, endAngle;
@synthesize curlBackLayer, maskBackLayer, curlLayer, maskCurlLayer;

- (void)dealloc
{
	[curlImage release];
	[curlBackLayer release];
	[maskBackLayer release];
	[curlLayer release];
	[maskCurlLayer release];
	[super dealloc];
}

- (void)setup
{
	CGImageRef curlImageRef = curlImage.CGImage;
	CGRect maskFrame = CGRectMake(0.0, 0.0, curlImage.size.width + curlImage.size.height, curlImage.size.width + curlImage.size.height);
	
	self.layer.masksToBounds = YES;
	
	self.curlBackLayer = [CALayer layer];
	curlBackLayer.contents = (id)curlImageRef;
	curlBackLayer.frame = self.frame;
	
	self.maskBackLayer = [CALayer layer];
	maskBackLayer.backgroundColor = [UIColor blueColor].CGColor;
	maskBackLayer.frame = maskFrame;
	maskBackLayer.anchorPoint = CGPointMake(0.0, 1.0);
	maskBackLayer.position = CGPointMake(0.0, 0.0);
	curlBackLayer.mask = maskBackLayer;
	[self.layer addSublayer:curlBackLayer];

	self.curlLayer = [CALayer layer];
	curlLayer.contents = (id)curlImageRef;
	curlLayer.frame = self.frame;
	curlLayer.anchorPoint = CGPointMake(0.0, 0.0);
	curlLayer.position = CGPointMake(0.0, 0.0);
	curlLayer.transform = CATransform3DMakeRotation(-endAngle, 0.0, 0.0, 1.0);
	
	self.maskCurlLayer = [CALayer layer];
	maskCurlLayer.backgroundColor = [UIColor blueColor].CGColor;
	maskCurlLayer.frame = maskFrame;
	maskCurlLayer.anchorPoint = CGPointMake(0.0, 0.0);
	maskCurlLayer.position = CGPointMake(0.0, 0.0);
	maskCurlLayer.transform = CATransform3DMakeRotation(endAngle, 0.0, 0.0, 1.0);
	curlLayer.mask = maskCurlLayer;	
	[self.layer addSublayer:curlLayer];
}

- (void)reset
{
	[maskBackLayer removeAllAnimations];
	[curlLayer removeAllAnimations];
	[maskCurlLayer removeAllAnimations];
	curlBackLayer.hidden = NO;
	curlLayer.mask = maskCurlLayer;
}

- (id)initWithImage:(UIImage*)image curlStartAngle:(float)aStartAngle curlEndAngle:(float)aEndAngle
{
    self.curlImage = image;
	self.startAngle = aStartAngle;
	self.endAngle = aEndAngle;
	CGRect curlFrame = CGRectMake(0.0, 0.0, curlImage.size.width, curlImage.size.height);
	return [self initWithFrame:curlFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)animate
{	
	CABasicAnimation *backMaskRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	backMaskRotation.toValue = [NSNumber numberWithFloat:startAngle];
	backMaskRotation.removedOnCompletion = NO;
	backMaskRotation.fillMode = kCAFillModeForwards;
	backMaskRotation.duration = kDuration;
	backMaskRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
	[maskBackLayer addAnimation:backMaskRotation forKey:@"BMrotate"];
	
	CABasicAnimation *curlMaskRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	curlMaskRotation.toValue = [NSNumber numberWithFloat:startAngle];
	curlMaskRotation.removedOnCompletion = NO;
	curlMaskRotation.fillMode = kCAFillModeForwards;
	curlMaskRotation.duration = kDuration;
	curlMaskRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
	[maskCurlLayer addAnimation:curlMaskRotation forKey:@"CMrotate"];

	CABasicAnimation *curlRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	curlRotation.toValue = [NSNumber numberWithFloat:0];
	curlRotation.removedOnCompletion = NO;
	curlRotation.fillMode = kCAFillModeForwards;
	curlRotation.duration = kDuration;
	curlRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
	curlRotation.delegate = self;
	[curlLayer addAnimation:curlRotation forKey:@"Crotate"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if (flag && anim == [curlLayer animationForKey:@"Crotate"])
	{
		curlBackLayer.hidden = YES;
		curlLayer.mask = nil;
	}
}

@end

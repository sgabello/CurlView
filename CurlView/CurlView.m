//
//  CurlView.m
//
//  Created by Andrea Ottolina on 28/08/2011.
//  Copyright 2011 Pixelinlove ltd. All rights reserved.
//

#import "CurlView.h"

#define	kDuration	0.3
#define kTiming		kCAMediaTimingFunctionEaseOut

@interface CurlView ()

@property (nonatomic, retain) UIImage *curlImage;
@property (nonatomic) float startAngle;
@property (nonatomic) float endAngle;

@property (nonatomic, retain) CALayer *curlBackLayer;
@property (nonatomic, retain) CALayer *curlLayer;

@end

@implementation CurlView

@synthesize curlImage, startAngle, endAngle;
@synthesize curlBackLayer, curlLayer;

- (void)dealloc
{
	[curlImage release];
	[curlBackLayer release];
	[curlLayer release];
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
	[self.layer addSublayer:curlBackLayer];
	
	CALayer *maskBackLayer = [CALayer layer];
	maskBackLayer.backgroundColor = [UIColor blueColor].CGColor;
	maskBackLayer.frame = maskFrame;
	maskBackLayer.anchorPoint = CGPointMake(0.0, 1.0);
	maskBackLayer.position = CGPointMake(0.0, 0.0);
	curlBackLayer.mask = maskBackLayer;

	self.curlLayer = [CALayer layer];
	curlLayer.contents = (id)curlImageRef;
	curlLayer.frame = self.frame;
	curlLayer.anchorPoint = CGPointMake(0.0, 0.0);
	curlLayer.position = CGPointMake(0.0, 0.0);
	[self.layer addSublayer:curlLayer];
	
	CALayer *maskCurlLayer = [CALayer layer];
	maskCurlLayer.backgroundColor = [UIColor blueColor].CGColor;
	maskCurlLayer.frame = maskFrame;
	maskCurlLayer.anchorPoint = CGPointMake(0.0, 0.0);
	maskCurlLayer.position = CGPointMake(0.0, 0.0);
	curlLayer.mask = maskCurlLayer;
	
	[self reset];
}

- (void)reset
{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	curlBackLayer.hidden = NO;
	curlBackLayer.mask.transform = CATransform3DIdentity;
	curlLayer.mask.hidden = YES;
	curlLayer.mask.transform = CATransform3DMakeRotation(endAngle, 0.0, 0.0, 1.0);
	curlLayer.transform = CATransform3DMakeRotation(-endAngle, 0.0, 0.0, 1.0);
	[CATransaction commit];
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
//	CABasicAnimation *backMaskRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//	backMaskRotation.toValue = [NSNumber numberWithFloat:startAngle];
//	backMaskRotation.removedOnCompletion = NO;
//	backMaskRotation.fillMode = kCAFillModeForwards;
//	backMaskRotation.duration = kDuration;
//	backMaskRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
//	[curlBackLayer.mask addAnimation:backMaskRotation forKey:@"BMrotate"];
//	
//	CABasicAnimation *curlMaskRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//	curlMaskRotation.toValue = [NSNumber numberWithFloat:startAngle];
//	curlMaskRotation.removedOnCompletion = NO;
//	curlMaskRotation.fillMode = kCAFillModeForwards;
//	curlMaskRotation.duration = kDuration;
//	curlMaskRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
//	[curlLayer.mask addAnimation:curlMaskRotation forKey:@"CMrotate"];

//	CABasicAnimation *curlRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//	curlRotation.toValue = [NSNumber numberWithFloat:0];
//	//curlRotation.removedOnCompletion = YES;
//	curlRotation.fillMode = kCAFillModeForwards;
//	curlRotation.duration = kDuration;
//	curlRotation.timingFunction = [CAMediaTimingFunction functionWithName:kTiming];
//	curlRotation.delegate = self;
//	[curlLayer addAnimation:curlRotation forKey:@"Crotate"];
	
	
	
	//	[curlBackLayer.mask setValue:[NSNumber numberWithFloat:startAngle] forKeyPath:@"transform.rotation.z"];
	//	[curlLayer.mask setValue:[NSNumber numberWithFloat:startAngle] forKeyPath:@"transform.rotation.z"];
	//	[curlLayer setValue:[NSNumber numberWithFloat:0] forKeyPath:@"transform.rotation.z"];
	
	[self reset];
	
	[CATransaction begin];
	[CATransaction setAnimationDuration:kDuration];
	[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kTiming]];
	[CATransaction setCompletionBlock:^(void) {
		[CATransaction setDisableActions:YES];
		curlBackLayer.hidden = YES;
		curlLayer.mask.transform = CATransform3DIdentity;
		[CATransaction setDisableActions:NO];
	}];
	curlLayer.mask.hidden = NO;
	curlBackLayer.mask.transform = CATransform3DMakeRotation(startAngle, 0.0, 0.0, 1.0);
	curlLayer.mask.transform = CATransform3DMakeRotation(startAngle, 0.0, 0.0, 1.0);
	curlLayer.transform = CATransform3DIdentity;
	[CATransaction commit];
}

@end

//
//  CurlViewDemoViewController.m
//  CurlViewDemo
//
//  Created by Andrea Ottolina on 29/08/2011.
//  Copyright 2011 Pixelinlove ltd. All rights reserved.
//

#import "CurlViewDemoViewController.h"
#import "CurlView.h"

#define kCurlStartAngle		0.645576
#define kCurlEndAngle		1.067953

@interface CurlViewDemoViewController ()

@property (nonatomic, retain) CurlView *curlView;

@end

@implementation CurlViewDemoViewController

@synthesize curlView;

- (void)viewDidLoad
{
	UIImage *curlImage = [UIImage imageNamed:@"curl.png"];
	CurlView *cView = [[CurlView alloc] initWithImage:curlImage curlStartAngle:kCurlStartAngle curlEndAngle:kCurlEndAngle];
	cView.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width - cView.frame.size.width, 0.0);
	
	self.curlView = cView;
	[cView release];
	
	[self.view addSubview:curlView];
	[curlView release];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
	[super dealloc];
}

- (IBAction)animate:(id)sender
{
	[self.curlView animate];
}

- (IBAction)reset:(id)sender
{
	[self.curlView reset];
}

@end
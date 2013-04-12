//
//  DDPageControlViewController.m
//  DDPageControl
//
//  Created by Damien DeVille on 1/14/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDPageControlViewController.h"
#import "DDPageControl.h"
#import <QuartzCore/QuartzCore.h>
#import "PKRevealController.h"

#define ARC4RANDOM_MAX	0x100000000


@implementation DDPageControlViewController

@synthesize scrollView ;


- (void)dealloc
{
	[scrollView release], scrollView = nil ;
	
	[super dealloc] ;
}

- (void)viewDidLoad
{
	[super viewDidLoad] ;
	
	int numberOfPages = 10 ;
	
    UIImage *backImage = [UIImage imageNamed:@"optionbutton.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(showLeftView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIImage *forwardImage = [UIImage imageNamed:@"home.png"];
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(280, 0, 40, 40);
    
    [forwardButton setImage:forwardImage forState:UIControlStateNormal];
    
    UIBarButtonItem *forwardBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = forwardBarButtonItem;

    
	// define the scroll view content size and enable paging
	[scrollView setPagingEnabled: YES] ;
	[scrollView setContentSize: CGSizeMake(scrollView.bounds.size.width * numberOfPages, scrollView.bounds.size.height-self.navigationController.navigationBar.frame.size.height)] ;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	
	// programmatically add the page control
	pageControl = [[DDPageControl alloc] init] ;
	[pageControl setCenter: CGPointMake(self.view.center.x, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-45.0f)] ;
	[pageControl setNumberOfPages: numberOfPages] ;
	[pageControl setCurrentPage: 0] ;
	[pageControl addTarget: self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
	[pageControl setDefersCurrentPageDisplay: YES] ;
	[pageControl setType: DDPageControlTypeOnFullOffEmpty] ;
	[pageControl setOnColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]] ;
	[pageControl setOffColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]] ;
	[pageControl setIndicatorDiameter: 8.0f] ;
	[pageControl setIndicatorSpace: 10.0f] ;
	[self.view addSubview: pageControl] ;
	[pageControl release] ;
	
	UILabel *pageLabel ;
	CGRect pageFrame ;
	UIColor *color ;
	char aLetter ;
	for (int i = 0 ; i < numberOfPages ; i++)
	{
		// determine the frame of the current page
        CGRect colorViewRect = CGRectMake(0, 7*(scrollView.bounds.size.height/9), scrollView.frame.size.width, 2*(scrollView.bounds.size.height/9));
        UIView *colorView = [[UIView alloc] initWithFrame:colorViewRect];
        colorView.backgroundColor = [UIColor colorWithRed:0.416 green:0.639 blue:0.576 alpha:1.000];
        self.view.backgroundColor = [UIColor colorWithRed:0.129 green:0.129 blue:0.133 alpha:1.000];
        scrollView.layer.cornerRadius = 12.0;
        scrollView.layer.masksToBounds = YES;


		pageFrame = CGRectMake(i * scrollView.bounds.size.width, 0.0f, scrollView.bounds.size.width, scrollView.bounds.size.height-self.navigationController.navigationBar.frame.size.height ) ;
		
		// create a page as a simple UILabel
		pageLabel = [[UILabel alloc] initWithFrame: pageFrame] ;
        CGRect nameframe = CGRectMake(0, 10, scrollView.bounds.size.width, 50);
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameframe];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithRed:0.416 green:0.639 blue:0.576 alpha:1.000];
        nameLabel.text = @"Redmond";
        nameLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:32];
        [pageLabel addSubview:nameLabel];
        [nameLabel release];
        
        
        CGRect timeframe = CGRectMake(0, nameLabel.frame.size.height, scrollView.bounds.size.width, scrollView.bounds.size.height - colorView.frame.size.height-nameLabel.frame.size.height);
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeframe];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRed:0.416 green:0.639 blue:0.576 alpha:1.000];
        timeLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:200];
        timeLabel.text = @"37";
        [pageLabel addSubview:timeLabel];

        [pageLabel addSubview:colorView];
		
		// add it to the scroll view
		[scrollView addSubview: pageLabel] ;
		[pageLabel release] ;
		
		// determine and set its (random) background color
		//color = [UIColor colorWithRed: (CGFloat)arc4random()/ARC4RANDOM_MAX green: (CGFloat)arc4random()/ARC4RANDOM_MAX blue: (CGFloat)arc4random()/ARC4RANDOM_MAX alpha: 1.0f] ;
        color = [UIColor colorWithRed:0.129 green:0.129 blue:0.133 alpha:1.000];
		[pageLabel setBackgroundColor: color] ;

		
		// set some label properties
        UIFont *sFont = [UIFont fontWithName:@"Helvetica Neue" size:72];

		[pageLabel setFont: sFont] ;
		[pageLabel setTextAlignment: NSTextAlignmentCenter] ;
		[pageLabel setTextColor: [UIColor colorWithRed:0.416 green:0.639 blue:0.576 alpha:1.000]] ;
		
		// set the label's text as the letter corresponding to the current page index
		aLetter = ((i+65)-(i/26)*26) ;	// the capitalized alphabet characters are in the range 65-90
		//[pageLabel setText: [NSString stringWithFormat: @"%c", aLetter]] ;
	}
}

- (void)viewDidUnload
{
	
}


#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
	DDPageControl *thePageControl = (DDPageControl *)sender ;
	
	// we need to scroll to the new index
	[scrollView setContentOffset: CGPointMake(scrollView.bounds.size.width * thePageControl.currentPage, scrollView.contentOffset.y) animated: YES] ;
}


#pragma mark -
#pragma mark UIScrollView delegate methods


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
	CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber ;
		
		// if we are dragging, we want to update the page control directly during the drag
		if (scrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
}

- (void)showLeftView:(id)sender
{
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait) ;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning] ;
}

@end

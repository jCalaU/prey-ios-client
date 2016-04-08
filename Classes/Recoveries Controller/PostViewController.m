//
//  PostViewController.h
//  Prey
//
//  Created by Javier Cala Uribe on 7/4/15.
//  Copyright (c) 2015 Fork Ltd. All rights reserved.
//

#import "PostViewController.h"
#import "Constants.h"

@interface PostViewController ()

@end

@implementation PostViewController

@synthesize titlePost;
@synthesize imagePost;
@synthesize contentView;
@synthesize scrollView;

- (id) init {
    self = [super init];
    if (self != nil)
    {
        [self.view setBackgroundColor:[UIColor colorWithRed:(240/255.f) green:(240/255.f) blue:(240/255.f) alpha:1.0]];
        
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0);        
        
        CGRect tmpFrame = (IS_IPAD) ? CGRectMake(0, 32, 768, 420) : CGRectMake(0, 32, 320, 210);
        imagePost = [[UIImageView alloc] initWithFrame:tmpFrame];
        imagePost.contentMode = UIViewContentModeScaleAspectFill;
        imagePost.clipsToBounds = YES;
        [scrollView addSubview:imagePost];

        tmpFrame = (IS_IPAD) ? CGRectMake(50,452,self.view.frame.size.width-100,70) : CGRectMake(10,242,self.view.frame.size.width-20,50);
        titlePost = [[UILabel alloc] initWithFrame:tmpFrame];
        titlePost.textAlignment = UITextAlignmentLeft;
        titlePost.numberOfLines = 2;
        if (IS_OS_6_OR_LATER) titlePost.adjustsLetterSpacingToFitWidth = YES;
        titlePost.adjustsFontSizeToFitWidth = YES;
        CGFloat fontSize = (IS_IPAD) ? 34 : 16;
        titlePost.font = [UIFont fontWithName:@"Roboto-Regular" size:fontSize];
        titlePost.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:titlePost];
        
        if (IS_IPAD)
            tmpFrame = CGRectMake(30, 522, 708,502);
        else
            tmpFrame = (IS_IPHONE5) ? CGRectMake(0, 295, 320,273) : CGRectMake(0, 295, 320,185);
        
        contentView = [[UIWebView alloc]initWithFrame:tmpFrame];
        contentView.delegate = self;
        
        [scrollView addSubview:contentView];
        
        [self.view addSubview:scrollView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Recoveries: Post";    
}


#pragma UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{    
    CGSize contentSize = webView.scrollView.contentSize;
    CGFloat webViewHeight = contentSize.height - webView.frame.size.height;
    if (webViewHeight < 0) webViewHeight = 0;
    
    [contentView.scrollView setScrollEnabled:NO];
    [contentView setFrame:CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y,
                                     contentSize.width, contentSize.height)];

    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height+webViewHeight)];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


@end

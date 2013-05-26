//
//  WebViewController.m
//  SuperSimpleBrowser
//
//  Created by Raphael Kuchta on 26.05.13.
//  Copyright (c) 2013 Raphael Kuchta. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize prevPage = _prevPage;
@synthesize nextPage = _nextPage;
@synthesize go = _go;
@synthesize addressField = _addressField;
@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openWebsite:(id)sender {
    NSString *urlString = self.addressField.text;
    
    if(![[urlString substringToIndex:7] isEqualToString:@"http://"]
       || ![[urlString substringToIndex:8] isEqualToString:@"https://"]) {
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
    
    [self.addressField resignFirstResponder];
}

- (IBAction)gotoPrevPage:(id)sender {
    [self.webView goBack];
}

- (IBAction)gotoNextPage:(id)sender {
    [self.webView goForward];
}


@end

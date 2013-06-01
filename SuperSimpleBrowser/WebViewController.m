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
@synthesize originalURL = _originalURL;

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
    self.webView.delegate = self;
    [self.prevPage setEnabled:NO];
    [self.nextPage setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openWebsite:(id)sender {
    NSString *urlString = self.addressField.text;
    // remember the original url for redirecting to google of loading fails 
    self.originalURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if([urlString length] < 8) {
        // if the url ist shorter than 8 chars it coul'd not contain the "http://"
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    } else if(![[urlString substringToIndex:7] isEqualToString:@"http://"]
       && ![[urlString substringToIndex:8] isEqualToString:@"https://"]) {
        // if it has not the "http://" or the "https://" prefix, add it now
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
    
    [self.addressField resignFirstResponder];
    
    
}

// navigate back in browser history
- (IBAction)gotoPrevPage:(id)sender {
    [self.webView goBack];
}

// navigate forward in browser history
- (IBAction)gotoNextPage:(id)sender {
    [self.webView goForward];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // activate the prev and next buttons after loading of the page finished
    if([self.webView canGoBack]) {
        [self.prevPage setEnabled:YES];
    } else {
        [self.prevPage setEnabled:NO];
    }
    
    if([self.webView canGoForward]) {
        [self.nextPage setEnabled:YES];
    } else {
        [self.nextPage setEnabled:NO];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // update the url in the adressfield to the currently requested url
    NSURL *loadingURL = request.URL;
    self.addressField.text = loadingURL.absoluteString;
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // if loading failed we redirect to google the original url
    NSString *googleOriginalURL = [NSString stringWithFormat:@"http://www.google.com/search?q=%@", self.originalURL];
    NSURL *url = [NSURL URLWithString:googleOriginalURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}


@end

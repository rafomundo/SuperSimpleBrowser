//
//  WebViewController.h
//  SuperSimpleBrowser
//
//  Created by Raphael Kuchta on 26.05.13.
//  Copyright (c) 2013 Raphael Kuchta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *prevPage;
@property (nonatomic, strong) IBOutlet UIButton *nextPage;
@property (nonatomic, strong) IBOutlet UIButton *go;
@property (nonatomic, strong) IBOutlet UITextField *addressField;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *originalURL;

- (IBAction)openWebsite:(id)sender;
- (IBAction)gotoPrevPage:(id)sender;
- (IBAction)gotoNextPage:(id)sender;

@end

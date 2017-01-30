//
//  CalendarVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/30/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "CalendarVC.h"
#import "ATRuntime.h"

@interface CalendarVC (){
    IBOutlet UIWebView *webView;
}

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[[ATRuntime data] config] objectForKey:[NSString stringWithFormat:@"calendar%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]]]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

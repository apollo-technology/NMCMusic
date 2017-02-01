//
//  CalendarVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/30/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "CalendarVC.h"
#import "IonIcons.h"
#import "ATRuntime.h"

@interface CalendarVC (){
    IBOutlet UIWebView *webView;
    IBOutlet UIBarButtonItem *chooseGroupButton;
}

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]) {
        [self selectChoir:nil];
    } else {
        [webView loadHTMLString:[[[ATRuntime data] config] objectForKey:[NSString stringWithFormat:@"calendar%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]]] baseURL:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]) {
        [self selectChoir:nil];
    }
}

-(IBAction)selectChoir:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select a Choir" message:@"You can always change this later by tapping the pencil icon." preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ragazzo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setHomeMessageFromChoirPref:@"Ragazzo"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cantus" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setHomeMessageFromChoirPref:@"Cantus"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Chamber Singers" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setHomeMessageFromChoirPref:@"ChamberSingers"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"GT Chorale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setHomeMessageFromChoirPref:@"GTChorale"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Canticum Novum" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setHomeMessageFromChoirPref:@"Canticum"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    alertController.view.tintColor = [ATRuntime nmcGreen];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setHomeMessageFromChoirPref:(NSString *)string{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"choirPref"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //do action
    [webView loadHTMLString:[[[ATRuntime data] config] objectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]] baseURL:nil];
}

@end

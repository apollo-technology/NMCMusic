//
//  HomeVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "HomeVC.h"
#import "IonIcons.h"
#import "ATRuntime.h"

@interface HomeVC (){
    IBOutlet UIImageView *musicImageView;
    IBOutlet UIImageView *videosImageView;
    IBOutlet UIImageView *pdfImageView;
    IBOutlet UIImageView *calendarImageView;
    IBOutlet UIImageView *contactImageView;
    
    IBOutlet UIView *musicView;
    IBOutlet UIView *videosView;
    IBOutlet UIView *pdfView;
    IBOutlet UIView *calendarView;
    IBOutlet UIView *contactView;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    musicImageView.image = [IonIcons imageWithIcon:ionmusicnote size:100 color:[ATRuntime nmcGreen]];
    videosImageView.image = [IonIcons imageWithIcon:ionsocialyoutube size:100 color:[ATRuntime nmcGreen]];
    pdfImageView.image = [IonIcons imageWithIcon:iondocumenttext size:100 color:[ATRuntime nmcGreen]];
    calendarImageView.image = [IonIcons imageWithIcon:ioncalendar size:100 color:[ATRuntime nmcGreen]];
    contactImageView.image = [IonIcons imageWithIcon:ionperson size:100 color:[ATRuntime nmcGreen]];
    
    UITapGestureRecognizer *songTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(songsTap)];
    [musicView addGestureRecognizer:songTap];
    
    UITapGestureRecognizer *videoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videosTap)];
    [videosView addGestureRecognizer:videoTap];
    
    UITapGestureRecognizer *pdfTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pdfsTap)];
    [pdfView addGestureRecognizer:pdfTap];
    
    UITapGestureRecognizer *calendarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calendarTap)];
    [calendarView addGestureRecognizer:calendarTap];
    
    UITapGestureRecognizer *contactTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contactTap)];
    [contactView addGestureRecognizer:contactTap];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]) {
        //do normal action
    }
}

-(void)viewDidAppear:(BOOL)animated{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"choirPref"]) {
        [self selectChoir:nil];
    }
}

-(void)songsTap{
    [self segueToVC:@"songRootVC"];
}

-(void)videosTap{
    [self segueToVC:@"videoRootVC"];
}

-(void)pdfsTap{
    [self segueToVC:@"pdfRootVC"];
}

-(void)calendarTap{
    [self segueToVC:@"calendarVC"];
}

-(void)contactTap{
    [self segueToVC:@"contactVC"];
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
}

-(void)segueToVC:(NSString *)vcID{
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:vcID];
    [self.navigationController pushViewController:newViewController animated:YES];
}

@end

//
//  InitialVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "InitialVC.h"
#import "ATRuntime.h"

@interface InitialVC ()

@end

@implementation InitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ATRuntime getAll:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSArray *allowedVersions = [[[ATRuntime data] config] objectForKey:@"allowedVersions"];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if ([allowedVersions containsObject:version]) {
                [self goHome];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Update" message:@"There is an update available. Please go to the app store and update this app." preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertController animated:YES completion:nil];

            }
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

-(void)goHome{
    UIViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
    [self presentViewController:homeVC animated:YES completion:nil];
}

@end

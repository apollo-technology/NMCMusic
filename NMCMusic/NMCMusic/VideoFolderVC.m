//
//  SongFolderVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "VideoFolderVC.h"
#import "TableViewCell.h"
#import "IonIcons.h"
#import <AVKit/AVKit.h>
#import "HCYoutubeParser.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoFolderVC ()

@end

@implementation VideoFolderVC

@synthesize folder;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return folder.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    ATItem *song = [folder.items objectAtIndex:indexPath.row];
    cell.titleLabel.text = song.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ATItem *song = [folder.items objectAtIndex:indexPath.row];
    [HCYoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:song.url] completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
        if (videoDictionary[@"medium"]) {
            NSString *mediumURL = videoDictionary[@"medium"];
            AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:mediumURL]];
            AVPlayerViewController *playerVC = [AVPlayerViewController new];
            playerVC.player = player;
            [self presentViewController:playerVC animated:YES completion:^{
                [player play];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
        } else {
            
        }
    }];
    
}



@end

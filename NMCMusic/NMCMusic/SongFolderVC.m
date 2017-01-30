//
//  SongFolderVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "SongFolderVC.h"
#import "TableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "IonIcons.h"
#import <AVKit/AVKit.h>

@interface SongFolderVC ()

@end

@implementation SongFolderVC

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
    AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:song.url]];
    NSLog(@"%@",song.url);
    AVPlayerViewController *playerVC = [AVPlayerViewController new];
    playerVC.player = player;
    [self presentViewController:playerVC animated:YES completion:^{
        [player play];
    }];
}

@end

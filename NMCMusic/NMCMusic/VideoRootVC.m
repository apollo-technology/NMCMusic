//
//  videoRootVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "VideoRootVC.h"
#import "TableViewCell.h"
#import "VideoChoirVC.h"
#import "ATRuntime.h"

@interface VideoRootVC ()

@end

@implementation VideoRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ATRuntime data] groupsForVideos] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.titleLabel.text = [[[ATRuntime data] groupsForVideos] objectAtIndex:[indexPath row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ATRuntime getFoldersForGroupForVideos:[[[ATRuntime data] groupsForVideos] objectAtIndex:[indexPath row]] block:^(NSArray *folders) {
        VideoChoirVC *videoChoirVC = [self.storyboard instantiateViewControllerWithIdentifier:@"videoChoirVC"];
        videoChoirVC.folders = folders;
        [self.navigationController pushViewController:videoChoirVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end

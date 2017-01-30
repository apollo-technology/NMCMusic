//
//  SongRootVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "SongRootVC.h"
#import "TableViewCell.h"
#import "SongChoirVC.h"
#import "ATRuntime.h"

@interface SongRootVC ()

@end

@implementation SongRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ATRuntime data] groupsForSongs] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.titleLabel.text = [[[ATRuntime data] groupsForSongs] objectAtIndex:[indexPath row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ATRuntime getFoldersForGroupForSongs:[[[ATRuntime data] groupsForSongs] objectAtIndex:[indexPath row]] block:^(NSArray *folders) {
        SongChoirVC *songChoirVC = [self.storyboard instantiateViewControllerWithIdentifier:@"songChoirVC"];
        songChoirVC.folders = folders;
        [self.navigationController pushViewController:songChoirVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end

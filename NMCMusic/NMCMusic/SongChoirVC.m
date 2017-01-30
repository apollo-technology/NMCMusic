//
//  SongChoirVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "SongChoirVC.h"
#import "TableViewCell.h"
#import "SongFolderVC.h"

@interface SongChoirVC ()

@end

@implementation SongChoirVC

@synthesize folders;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return folders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    ATFolder *folder = [folders objectAtIndex:indexPath.row];
    cell.titleLabel.text = folder.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SongFolderVC *songFolderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"songFolderVC"];
    songFolderVC.folder = [folders objectAtIndex:indexPath.row];;
    [self.navigationController pushViewController:songFolderVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

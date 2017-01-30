//
//  SongFolderVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "PDFFolderVC.h"
#import "TableViewCell.h"
#import "IonIcons.h"
#import "ATRuntime.h"
#import <SafariServices/SafariServices.h>

@interface PDFFolderVC ()

@end

@implementation PDFFolderVC

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
    ATItem *pdf = [folder.items objectAtIndex:indexPath.row];
    SFSafariViewController *browser = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:pdf.url]];
    browser.view.tintColor = [ATRuntime nmcGreen];
    [self.navigationController pushViewController:browser animated:YES];
}



@end

//
//  videoRootVC.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "PDFRootVC.h"
#import "TableViewCell.h"
#import "PDFChoirVC.h"
#import "ATRuntime.h"

@interface PDFRootVC ()

@end

@implementation PDFRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ATRuntime data] groupsForPDFs] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.titleLabel.text = [[[ATRuntime data] groupsForPDFs] objectAtIndex:[indexPath row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ATRuntime getFoldersForGroupForPDFs:[[[ATRuntime data] groupsForPDFs] objectAtIndex:[indexPath row]] block:^(NSArray *folders) {
        PDFChoirVC *pdfChoirVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfChoirVC"];
        pdfChoirVC.folders = folders;
        [self.navigationController pushViewController:pdfChoirVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end

//
//  VideoFolderVC.h
//  NMCMusic
//
//  Created by Elijah Cobb on 1/29/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATRuntime.h"

@interface VideoFolderVC : UITableViewController{
    ATFolder *folder;
}

@property ATFolder *folder;


@end

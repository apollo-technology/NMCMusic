//
//  MediaDB.m
//  NMCMusic
//
//  Created by Elijah Cobb on 1/28/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "ATRuntime.h"

@implementation ATRuntime

+(instancetype)data{
    static ATRuntime *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

+(UIColor *)nmcGreen{
    return [UIColor colorWithRed:0.086 green:0.518 blue:0.400 alpha:1.00];
}

+(void)getSongs:(void (^)(BOOL succeeded,NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:@"songs"];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            if (block) {
                block(NO,error);
            }
        } else {
            NSMutableArray *songsTemp = [NSMutableArray new];
            NSMutableArray *foldersTemp = [NSMutableArray new];
            NSMutableArray *groupsTemp = [NSMutableArray new];
            for (PFObject *object in objects) {
                ATItem *song = [ATItem new];
                song.name = object[@"name"];
                song.url = [object[@"url"] stringByReplacingOccurrencesOfString:@"dl=0" withString:@"dl=1"];
                song.groups = object[@"groups"];
                song.folders = object[@"folders"];
                [songsTemp addObject:song];
                for (NSString *folder in song.folders) {
                    if (![foldersTemp containsObject:folder]) {
                        [foldersTemp addObject:folder];
                    }
                }
                for (NSString *group in song.groups) {
                    if (![groupsTemp containsObject:group]) {
                        [groupsTemp addObject:group];
                    }
                }
            }
            [[ATRuntime data] setSongs:songsTemp];
            [[ATRuntime data] setFoldersForSongs:foldersTemp];
            [[ATRuntime data] setGroupsForSongs:groupsTemp];
            if (block) {
                block(YES,nil);
            }
        }
    }];
}

+(void)getFoldersForGroupForSongs:(NSString *)group block:(void (^)(NSArray *folders))block{
    NSPredicate *groupPredicate = [NSPredicate predicateWithFormat: @"groups contains[cd] %@", group];
    NSArray *songsWithGroup = [[[ATRuntime data] songs] filteredArrayUsingPredicate:groupPredicate];
    
    NSMutableArray *foldersInGroup = [NSMutableArray new];
    for (ATItem *song in songsWithGroup) {
        for (NSString *folder in song.folders) {
            if (![foldersInGroup containsObject:folder]) {
                [foldersInGroup addObject:folder];
            }
        }
    }
    
    NSMutableArray *tempFolders = [NSMutableArray new];
    for (NSString *folderName in foldersInGroup) {
        ATFolder *folder = [ATFolder new];
        folder.name = folderName;
        
        NSPredicate *folderPredicate = [NSPredicate predicateWithFormat: @"folders contains[cd] %@", folderName];
        NSArray *songsWithBoth = [songsWithGroup filteredArrayUsingPredicate:folderPredicate];
        folder.items = songsWithBoth;
        
        [tempFolders addObject:folder];
    }
    
    if (block) {
        block(tempFolders);
    }
}

+(void)getVideos:(void (^)(BOOL succeeded,NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:@"videos"];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            if (block) {
                block(NO,error);
            }
        } else {
            NSMutableArray *songsTemp = [NSMutableArray new];
            NSMutableArray *foldersTemp = [NSMutableArray new];
            NSMutableArray *groupsTemp = [NSMutableArray new];
            for (PFObject *object in objects) {
                ATItem *song = [ATItem new];
                song.name = object[@"name"];
                song.url = [object[@"url"] stringByReplacingOccurrencesOfString:@"dl=0" withString:@"dl=1"];
                song.groups = object[@"groups"];
                song.folders = object[@"folders"];
                [songsTemp addObject:song];
                for (NSString *folder in song.folders) {
                    if (![foldersTemp containsObject:folder]) {
                        [foldersTemp addObject:folder];
                    }
                }
                for (NSString *group in song.groups) {
                    if (![groupsTemp containsObject:group]) {
                        [groupsTemp addObject:group];
                    }
                }
            }
            [[ATRuntime data] setVideos:songsTemp];
            [[ATRuntime data] setFoldersForVideos:foldersTemp];
            [[ATRuntime data] setGroupsForVideos:groupsTemp];
            if (block) {
                block(YES,nil);
            }
        }
    }];
}

+(void)getFoldersForGroupForVideos:(NSString *)group block:(void (^)(NSArray *folders))block{
    NSPredicate *groupPredicate = [NSPredicate predicateWithFormat: @"groups contains[cd] %@", group];
    NSArray *songsWithGroup = [[[ATRuntime data] videos] filteredArrayUsingPredicate:groupPredicate];
    
    NSMutableArray *foldersInGroup = [NSMutableArray new];
    for (ATItem *song in songsWithGroup) {
        for (NSString *folder in song.folders) {
            if (![foldersInGroup containsObject:folder]) {
                [foldersInGroup addObject:folder];
            }
        }
    }
    
    NSMutableArray *tempFolders = [NSMutableArray new];
    for (NSString *folderName in foldersInGroup) {
        ATFolder *folder = [ATFolder new];
        folder.name = folderName;
        
        NSPredicate *folderPredicate = [NSPredicate predicateWithFormat: @"folders contains[cd] %@", folderName];
        NSArray *songsWithBoth = [songsWithGroup filteredArrayUsingPredicate:folderPredicate];
        folder.items = songsWithBoth;
        
        [tempFolders addObject:folder];
    }
    
    if (block) {
        block(tempFolders);
    }
}

+(void)getPDFs:(void (^)(BOOL succeeded,NSError *error))block{
    PFQuery *query = [PFQuery queryWithClassName:@"pdfs"];
    [query setLimit:1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            if (block) {
                block(NO,error);
            }
        } else {
            NSMutableArray *songsTemp = [NSMutableArray new];
            NSMutableArray *foldersTemp = [NSMutableArray new];
            NSMutableArray *groupsTemp = [NSMutableArray new];
            for (PFObject *object in objects) {
                ATItem *song = [ATItem new];
                song.name = object[@"name"];
                song.url = [object[@"url"] stringByReplacingOccurrencesOfString:@"dl=0" withString:@"dl=1"];
                song.groups = object[@"groups"];
                song.folders = object[@"folders"];
                [songsTemp addObject:song];
                for (NSString *folder in song.folders) {
                    if (![foldersTemp containsObject:folder]) {
                        [foldersTemp addObject:folder];
                    }
                }
                for (NSString *group in song.groups) {
                    if (![groupsTemp containsObject:group]) {
                        [groupsTemp addObject:group];
                    }
                }
            }
            [[ATRuntime data] setPdfs:songsTemp];
            [[ATRuntime data] setFoldersForPDFs:foldersTemp];
            [[ATRuntime data] setGroupsForPDFs:groupsTemp];
            if (block) {
                block(YES,nil);
            }
        }
    }];
}

+(void)getFoldersForGroupForPDFs:(NSString *)group block:(void (^)(NSArray *folders))block{
    NSPredicate *groupPredicate = [NSPredicate predicateWithFormat: @"groups contains[cd] %@", group];
    NSArray *songsWithGroup = [[[ATRuntime data] pdfs] filteredArrayUsingPredicate:groupPredicate];
    
    NSMutableArray *foldersInGroup = [NSMutableArray new];
    for (ATItem *song in songsWithGroup) {
        for (NSString *folder in song.folders) {
            if (![foldersInGroup containsObject:folder]) {
                [foldersInGroup addObject:folder];
            }
        }
    }
    
    NSMutableArray *tempFolders = [NSMutableArray new];
    for (NSString *folderName in foldersInGroup) {
        ATFolder *folder = [ATFolder new];
        folder.name = folderName;
        
        NSPredicate *folderPredicate = [NSPredicate predicateWithFormat: @"folders contains[cd] %@", folderName];
        NSArray *songsWithBoth = [songsWithGroup filteredArrayUsingPredicate:folderPredicate];
        folder.items = songsWithBoth;
        
        [tempFolders addObject:folder];
    }
    
    if (block) {
        block(tempFolders);
    }
}

+(void)getCongfig:(void (^)(BOOL succeeded,NSError *error))block{
    [PFConfig getConfigInBackgroundWithBlock:^(PFConfig * _Nullable config, NSError * _Nullable error) {
        if (error) {
            if (block) {
                block(NO,error);
            }
        } else {
            [[ATRuntime data] setConfig:config];
            if (block) {
                block(YES,nil);
            }
        }
    }];
}

+(void)getAll:(void (^)(BOOL succeeded,NSError *error))block{
    [ATRuntime getSongs:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            if (block) {
                block(NO,error);
            }
        } else {
            [ATRuntime getVideos:^(BOOL succeeded, NSError *error) {
                if (!succeeded) {
                    if (block) {
                        block(NO,error);
                    }
                } else {
                    [ATRuntime getPDFs:^(BOOL succeeded, NSError *error) {
                        if (!succeeded) {
                            if (block) {
                                block(NO,error);
                            }
                        } else {
                            [ATRuntime getCongfig:^(BOOL succeeded, NSError *error) {
                                if (!succeeded) {
                                    if (block) {
                                        block(NO,error);
                                    }
                                } else {
                                    if (block) {
                                        block(YES,nil);
                                    }
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

@end

@implementation ATItem

@end

@implementation ATFolder

@end

//
//  MediaDB.h
//  NMCMusic
//
//  Created by Elijah Cobb on 1/28/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import <Parse/Parse.h>

@interface ATRuntime : NSObject
+(instancetype)data;
@property NSArray *songs;
@property NSArray *videos;
@property NSArray *pdfs;
@property NSArray *foldersForSongs;
@property NSArray *groupsForSongs;
@property NSArray *foldersForVideos;
@property NSArray *groupsForVideos;
@property NSArray *foldersForPDFs;
@property NSArray *groupsForPDFs;
@property PFConfig *config;
+(UIColor *)nmcGreen;
+(void)getSongs:(void (^)(BOOL succeeded,NSError *error))block;
+(void)getFoldersForGroupForSongs:(NSString *)group block:(void (^)(NSArray *folders))block;
+(void)getVideos:(void (^)(BOOL succeeded,NSError *error))block;
+(void)getFoldersForGroupForVideos:(NSString *)group block:(void (^)(NSArray *folders))block;
+(void)getPDFs:(void (^)(BOOL succeeded,NSError *error))block;
+(void)getFoldersForGroupForPDFs:(NSString *)group block:(void (^)(NSArray *folders))block;
+(void)getCongfig:(void (^)(BOOL succeeded,NSError *error))block;
+(void)getAll:(void (^)(BOOL succeeded,NSError *error))block;
@end

@interface ATItem : NSObject
@property NSString *name;
@property NSString *url;
@property NSArray *groups;
@property NSArray *folders;
@end

@interface ATFolder : NSObject
@property NSString *name;
@property NSArray *items;
@end

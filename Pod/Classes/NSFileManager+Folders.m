//
//  NSFileManager+Folders.m
//  Folders
//
//  Created by Stefano Zanetti on 29/01/16.
//  Copyright © 2016 Stefano Zanetti. All rights reserved.
//

#import "NSFileManager+Folders.h"

NSString * const FLDFolderDomain = @"it.folder";

typedef NS_ENUM(NSInteger, FLDFolderError) {
    FLDFolderErrorPathNotFound
};

@implementation NSFileManager (Folders)

#pragma mark - Private methods

dispatch_queue_t backgroundFolderQueue() {
    static dispatch_once_t queueCreationGuard;
    static dispatch_queue_t queue;
    dispatch_once(&queueCreationGuard, ^{
        queue = dispatch_queue_create("it.folders.backgroundQueue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

+ (NSString *)fld_appFolder {
    static dispatch_once_t onceToken;
    static NSString *appFolder = nil;
    dispatch_once(&onceToken, ^{
        NSLog(@"----> [FOLDERS] REMEMBER TO CHECK ICLOUD BACKUP ALLOWED FOLDERS <----");
        appFolder = [[NSBundle mainBundle] objectForInfoDictionaryKey:(id)kCFBundleIdentifierKey];
    });
    
    return appFolder;
}

+ (NSString *)fld_findOrCreateFolder:(NSSearchPathDirectory)folder
                              domain:(NSSearchPathDomainMask)domain
                       pathComponent:(NSString *)pathComponent
                               error:(NSError **)error {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(folder, domain, YES);
    if ([paths count] == 0) {
        if (*error) {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey : NSLocalizedStringFromTable(@"No path found for directory in domain.", @"Errors", nil),
                                       @"NSSearchPathDirectory" : [NSNumber numberWithInteger:folder],
                                       @"NSSearchPathDomainMask" : [NSNumber numberWithInteger:domain]
                                       };
            
            *error = [NSError errorWithDomain:FLDFolderDomain
                                         code:FLDFolderErrorPathNotFound
                                     userInfo:userInfo];
        }
        return nil;
    }
    
    NSString *path = [paths firstObject];
    
    if (pathComponent) {
        path = [path stringByAppendingPathComponent:pathComponent];
    }
    
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    if (!success) {
        return nil;
    }
    
    return path;
}

+ (BOOL)fld_addExcludeBackupAttributeToItemAtURL:(NSURL *)URL {
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES)
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if(!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}

#pragma mark - Public methods

+ (NSString *)fld_documentFolder {
    
    static dispatch_once_t onceToken;
    static NSString *document = nil;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        
        document = [self fld_findOrCreateFolder:NSDocumentDirectory
                                         domain:NSUserDomainMask
                                  pathComponent:[self fld_appFolder]
                                          error:&error];
        
        if (!document) {
            NSLog(@"Unable to find or create document directory:\n%@", error);
        }
    });
    
    return document;
}

+ (NSString *)fld_applicationSupportFolder {

    static dispatch_once_t onceToken;
    static NSString *application = nil;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        
        application = [self fld_findOrCreateFolder:NSApplicationSupportDirectory
                                            domain:NSUserDomainMask
                                     pathComponent:[self fld_appFolder]
                                             error:&error];
        
        if (!application) {
            NSLog(@"Unable to find or create application support directory:\n%@", error);
        }
    });
    
    return application;
}

+ (NSString *)fld_cachesFolder {
    
    static dispatch_once_t onceToken;
    static NSString *caches = nil;
    
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        caches = [self fld_findOrCreateFolder:NSCachesDirectory
                                       domain:NSUserDomainMask
                                pathComponent:[self fld_appFolder]
                                        error:&error];
        
        if (!caches) {
            NSLog(@"Unable to find or create caches directory:\n%@", error);
        }
    });
    
    return caches;
}

+ (BOOL)fld_createFolder:(NSString *)folder {
    
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Unable to find or create %@ directory:\n%@", folder, error);
    }
    
    return success;
}

+ (BOOL)fld_emptyFolder:(NSString *)folder {
    
    NSError *error = nil;
    BOOL success = [self fld_deleteItem:folder];
    
    success = [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Unable to create directory:\n%@", error);
    }
    
    return success;
}

+ (BOOL)fld_deleteItem:(NSString *)item {
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:item]) {
        return YES;
    }
    
    NSString *itemToDelete = [item stringByAppendingString:[NSString stringWithFormat:@"_%zd_to_delete", [NSDate timeIntervalSinceReferenceDate]]];
    
    BOOL success = [[NSFileManager defaultManager] moveItemAtPath:item
                                                           toPath:itemToDelete
                                                            error:&error];
    if (!success) {
        NSLog(@"Unable to move item:\n%@", error);
    } else {
        dispatch_async(backgroundFolderQueue(), ^{
            NSError *deleteError = nil;
            BOOL deleteSucces = [[NSFileManager defaultManager] removeItemAtPath:itemToDelete error:&deleteError];
            
            if (!deleteSucces) {
                NSLog(@"Unable to delete item:\n%@", deleteError);
            }
        });
    }
    
    return success;
}

+ (BOOL)fld_excludeFolderFromBackup:(NSString *)folder {
    return [self fld_addExcludeBackupAttributeToItemAtURL:[[NSURL alloc] initFileURLWithPath:folder]];
}

@end

//
//  NSString+Folders.h
//  Folders
//
//  Created by Stefano Zanetti on 29/01/16.
//  Copyright © 2016 Stefano Zanetti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Folders)

+ (NSString *)fld_documentFolder;

+ (NSString *)fld_applicationSupportFolder;

+ (NSString *)fld_cachesFolder;

+ (BOOL)fld_excludeFolderFromBackup:(NSString *)folder;

+ (NSString *)fld_findOrCreateFolder:(NSString *)folder inFolder:(NSString *)inFolder error:(NSError **)error;

@end

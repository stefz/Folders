//
//  NSFileManager+Folders.h
//  Folders
//
//  Created by Stefano Zanetti on 29/01/16.
//  Copyright © 2016 Stefano Zanetti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Folders)

/**
 *  Creates a folder named with the app bundle identifier inside the Document Directory
 *
 *  @return the full path of the folder just created
 */

+ (NSString *)fld_documentFolder;

/**
 *  Creates a folder named with the app bundle identifier inside the Application Support Directory
 *
 *  @return the full path of the folder just created
 */

+ (NSString *)fld_applicationSupportFolder;

/**
 *  Creates a folder named with the app bundle identifier inside the Caches Directory
 *
 *  @return the full path of the folder just created
 */

+ (NSString *)fld_cachesFolder;

/**
 *  Creates a folder at a specified path
 *
 *  @param folder the user path to  be created
 *
 *  @return a boolean to know if the operation is gone right or not
 */

+ (BOOL)fld_createFolder:(NSString *)folder;

/**
 *  Removes all files contained in a folder
 *
 *  @param folder the user path to be empty
 *
 *  @return a boolean to know if the operation is gone right or not
 */

+ (BOOL)fld_emptyFolder:(NSString *)folder;

/**
 *  Removes a folder
 *
 *  @param folder the user path to be removed
 *
 *  @return a boolean to know if the operation is gone right or not
 */

+ (BOOL)fld_deleteFolder:(NSString *)folder;

/**
 *  Excludes folder from iCloud backup. Only the Caches Directory is automatically excluded by Apple
 *
 *  @param folder the user path to be excluded from iCloud backup
 *
 *  @return a boolean to know if the operation is gone right or not
 */

+ (BOOL)fld_excludeFolderFromBackup:(NSString *)folder;

@end

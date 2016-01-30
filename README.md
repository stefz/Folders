# Folders

[![CI Status](http://img.shields.io/travis/Stefano Zanetti/Folders.svg?style=flat)](https://travis-ci.org/Stefano Zanetti/Folders)
[![Version](https://img.shields.io/cocoapods/v/Folders.svg?style=flat)](http://cocoapods.org/pods/Folders)
[![License](https://img.shields.io/cocoapods/l/Folders.svg?style=flat)](http://cocoapods.org/pods/Folders)
[![Platform](https://img.shields.io/cocoapods/p/Folders.svg?style=flat)](http://cocoapods.org/pods/Folders)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objective-c
NSLog(@"Application Support Folder: %@", [NSFileManager fld_applicationSupportFolder]);

NSLog(@"Documents Folder: %@", [NSFileManager fld_documentFolder]);

NSLog(@"Caches Folder: %@", [NSFileManager fld_cachesFolder]);

NSString *folder = [[NSFileManager fld_applicationSupportFolder] stringByAppendingPathComponent:@"Temp"];

BOOL success = [NSFileManager fld_createFolder:folder];

NSLog(@"Created Folder: %@ - Success: %@ ", folder, success ? @"YES" : @"NO");

success = [NSFileManager fld_emptyFolder:folder];

NSLog(@"Empty Folder: %@ - Success: %@ ", folder, success ? @"YES" : @"NO");

```

## Requirements

## Installation

Folders is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Folders"
```

## Author

Stefano Zanetti, stefano.zanetti@pragmamark.org

## License

Folders is available under the MIT license. See the LICENSE file for more info.

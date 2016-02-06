#
# Be sure to run `pod lib lint Folders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Folders"
  s.version          = "0.1.0"
  s.summary          = "Just a NSFileManager category to be fast with folders..."
  s.description      = "Basically it creates a folder named with the app bundle identifier inside the Document, Application Support and Caches Directories. This because is more simple to manage some situation. For example if you want to delete the entire content of a directory (with a lot of file...) Folder does it in background but the current directory is clean and ready to use immediately."

  s.homepage         = "https://github.com/stefz/Folders"
  s.license          = 'MIT'
  s.author           = { "Stefano Zanetti" => "stefano.zanetti@pragmamark.org" }
  s.source           = { :git => "https://github.com/stefz/Folders.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stezanna'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end

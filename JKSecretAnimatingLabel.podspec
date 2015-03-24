#Taken from podspec file for repository - https://github.com/rounak/RJImageLoader/blob/master/RJImageLoader.podspec
# Be sure to run `pod lib lint JKSecretAnimatingLabel.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JKSecretAnimatingLabel"
  s.version          = "1.0"
  s.summary          = "iOS library to implement the shiny, secret label animation"
  s.description      = <<-DESC
                       A library to make the shiny, secret label animation. Inspired from article 'Replicating The Secret iOS App Text Animation'
                       from http://natashatherobot.com/secret-ios-app-text-animation/
                       DESC
  s.homepage         = "https://github.com/jayesh15111988/JKSecretAnimatingLabel/"
  s.license          = 'MIT'
  s.author           = { "Jayesh Kawli" => "j.kawli@gmail.com" }
  s.source           = { :git => "https://github.com/jayesh15111988/JKSecretAnimatingLabel.git", :branch => 'master' }
  s.social_media_url = 'https://twitter.com/JayeshKawli'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'JKSecretAnimatingLabel/Classes/*.{h,m}'
end

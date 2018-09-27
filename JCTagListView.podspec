#
# Be sure to run `pod lib lint JCTagListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JCTagListView'
  s.version          = '2.0.0'
  s.summary          = 'Support select tags and settings tags style.'
  s.homepage         = 'http://lijingcheng.github.io/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lijingcheng' => 'bj_lijingcheng@163.com' }
  s.source           = { :git => 'https://github.com/lijingcheng/JCTagListView.git', :tag => s.version.to_s }
  s.social_media_url = 'http://weibo.com/lijingcheng1984'
  s.ios.deployment_target = '9.0'
  s.source_files = 'JCTagListView/Classes/**/*'
end

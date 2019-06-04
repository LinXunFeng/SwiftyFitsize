Pod::Spec.new do |s|
  s.name             = 'SwiftyFitsize'
  s.version          = '1.0.0'
  s.summary          = '📱 Swifty screen adaptation solution'
  s.homepage         = 'https://github.com/LinXunFeng/SwiftyFitsize'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinXunFeng' => '598600855@qq.com' }
  s.source           = { :git => 'https://github.com/LinXunFeng/SwiftyFitsize.git', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/*.{h,swift}'
  s.public_header_files = 'Sources/*.h'
  
end

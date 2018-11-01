Pod::Spec.new do |s|
  s.name             = 'SwiftyFitsize'
  s.version          = '0.2.0'
  s.summary          = '📱 Swifty screen adaptation solution'
  s.homepage         = 'https://github.com/LinXunFeng/SwiftyFitsize'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinXunFeng' => '598600855@qq.com' }
  s.source           = { :git => 'https://github.com/LinXunFeng/SwiftyFitsize.git', :tag => s.version.to_s }

  s.source_files = 'Sources/*.swift'
  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'
end

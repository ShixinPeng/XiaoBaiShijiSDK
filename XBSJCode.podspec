
Pod::Spec.new do |s|
  s.name             = 'XBSJCode'
  s.version          = '0.1.0'
  s.summary          = '小白世纪SDK,官方cocopod部署'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ShixinPeng/XiaobaiShijiSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pengshixin' => 'shixinpeng0429@163.com' }
  s.source           = { :git => 'https://github.com/ShixinPeng/XiaobaiShijiSDK', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'XBSJCode/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XBSJCode' => ['XBSJCode/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

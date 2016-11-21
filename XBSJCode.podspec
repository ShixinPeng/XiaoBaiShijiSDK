

Pod::Spec.new do |s|

  s.name         = "XBSJCode"
  s.version      = "0.0.2"
  s.summary      = "小白世纪SDK,cocoPods部署"
  s.description  = <<-DESC
    北京小白世纪网络科技有限公司移动端视频互动iOS端SDK,利用小白世纪的深度学习和机器学习技术，快速识别视屏标签，服务于互联网媒体，购物商城的导流。
                   DESC
  s.homepage     = "https://github.com/ShixinPeng/XiaobaiShijiSDK"

  s.license      = { :type => 'Copyright', :text => 'Copyright ©2014-2016 xiaobaishiji.com' }

  s.author             = { "pengshixin" => "shixinpeng0429@163.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/ShixinPeng/XiaobaiShijiSDK.git", :tag => "0.0.2" }

s.source_files  = "VideoFetch/framework/*.{framework}"

#s.public_header_files = "framework/XBVideoAdvertSDK.framework/Headers/*.{h}"

end

Pod::Spec.new do |s|
  #pod的名字 
  s.name             = 'WGBRouterManager'
  #版本号 与git的tag相关联
  s.version          = '1.0.3'
  #摘要描述
  s.summary          = '测试打包静态库.'
  #详细描述
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  #主页/介绍网站等
  s.homepage         = 'https://github.com/WangGuibin/WGBRouterManager'
  #MIT证书
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  #作者
  s.author           = { 'CoderWGB' => '864562082@qq.com' }
  # .podspec远端路径
  s.source           = { :git => 'https://github.com/WangGuibin/WGBRouterManager.git', :tag => s.version.to_s }
  #支持部署的系统环境
  s.ios.deployment_target = '9.0'
  #匹配库文件路径
  s.source_files = 'WGBRouterManager/Classes/**/*'
  #依赖的第三方静态库
  #s.vendored_libraries = 'WGBRouterManager.a'
  #依赖的第三方framework
  #s.ios.vendored_framework = 'WGBRouterManager.framework'
  #需要暴露的头文件
  s.public_header_files = 'WGBRouterManager/*.h'

  #打静态库需要以下两个配置
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #库依赖的资源文件
  # s.resource_bundles = {
  #   'WGBRouterManager' => ['WGBRouterManager/Assets/*.png']
  # }

  #依赖系统框架
  s.frameworks = 'UIKit', 'Foundation'
  #依赖第三方库
  s.dependency 'AFNetworking', '~> 3.0'
end

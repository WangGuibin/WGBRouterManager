Pod::Spec.new do |s|
  s.name = "WGBRouterManager"
  s.version = "1.0.3"
  s.summary = "\u6D4B\u8BD5\u6253\u5305\u9759\u6001\u5E93."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"CoderWGB"=>"864562082@qq.com"}
  s.homepage = "https://github.com/WangGuibin/WGBRouterManager"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "Foundation"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/WGBRouterManager.framework'
end

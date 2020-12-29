# WGBRouterManager

[![CI Status](https://img.shields.io/travis/WangGuibin/WGBRouterManager.svg?style=flat)](https://travis-ci.org/WangGuibin/WGBRouterManager)
[![Version](https://img.shields.io/cocoapods/v/WGBRouterManager.svg?style=flat)](https://cocoapods.org/pods/WGBRouterManager)
[![License](https://img.shields.io/cocoapods/l/WGBRouterManager.svg?style=flat)](https://cocoapods.org/pods/WGBRouterManager)
[![Platform](https://img.shields.io/cocoapods/p/WGBRouterManager.svg?style=flat)](https://cocoapods.org/pods/WGBRouterManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

WGBRouterManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WGBRouterManager'
```

## Author

CoderWGB, 864562082@qq.com

## License

WGBRouterManager is available under the MIT license. See the LICENSE file for more info.


## 实践过程

### 安装`cocoapods`插件`cocoapods-packager`

```bash
sudo gem install cocoapods-packager 

```
### 创建`pod lib` 
1. 直接使用`pod lib create xxx` 模板创建 
2. 把`xxx/Classes/`目录下的文件替换成你自己的库文件
3. 修改`xxx.podspec`文件 (划重点!!!)

```ruby
Pod::Spec.new do |s|
  #pod的名字 
  s.name             = 'WGBRouterManager'
  #版本号 与git的tag相关联
  s.version          = '1.0.2'
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

  #打静态库需要以下两个配置(Xcode12.3如果不加 会报错 亲测!)
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

```
![报错](https://cdn.jsdelivr.net/gh/WangGuibin/WGBRouterManager/1.png)

![未报错](https://cdn.jsdelivr.net/gh/WangGuibin/WGBRouterManager/1.png)


4. `cd`到`Example`目录下`pod install`
5. 提交代码,打上tag,推送到远端
```bash
git add .
git commit -m 'xxx'
git tag 1.0.2
git push -u origin main 
git push origin --tags

```

### 打静态库出包
`cd`回到`WGBRouterManager.podspec`所在目录下

```bash
#framework静态库
pod package WGBRouterManager.podspec --force
# .a静态库
pod package WGBRouterManager.podspec --library --force 
```

### 打包完展示,打完收工!!!
![](https://cdn.jsdelivr.net/gh/WangGuibin/WGBRouterManager/3.png)



#!/bin/bash

echo <<EOF
sh buildFramework.sh all #编译通用库
sh buildFramework.sh sim #编译模拟器包
sh buildFramework.sh ios #编译真机包
EOF

#创建存放目录
mkdir -p ${PROJECT_NAME}_SDK
cd ${PROJECT_NAME}_SDK
INSTALL_DIR=./${PROJECT_NAME}.framework

#真机编译产物
IOS_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework
#模拟器编译产物
SIMULATOR_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework

cd ..

buildPackAll(){
  if [ ! -d "${IOS_DIR}" -o ! -d "${SIMULATOR_DIR}" ]; then
      judgeDirExist
      exit 0
    else
      lipo -create ${IOS_DIR}/${PROJECT_NAME}  ${SIMULATOR_DIR}/${PROJECT_NAME} -output ${IOS_DIR}/${PROJECT_NAME}
      cp -R ${IOS_DIR}/ ./${PROJECT_NAME}_SDK/${INSTALL_DIR}/
      echo "✅真机和模拟器SDK合并成功!!"
      say "真机和模拟器SDK合并成功"
  fi
}

judgeDirExist(){
  if [[ -d "${IOS_DIR}" ]]; then
    echo "真机编译完成,请继续模拟器编译"
    say "真机编译完成,请继续模拟器编译"
  fi

  if [[ -d "${SIMULATOR_DIR}" ]]; then
    echo "模拟器编译完成,请继续真机编译"
    say "模拟器编译完成,请继续真机编译"
  fi
}

buildPackSim(){
if [[ -d "${SIMULATOR_DIR}" ]]; then
    cp -R ${SIMULATOR_DIR}/ ./${PROJECT_NAME}_SDK/${INSTALL_DIR}/
    echo "✅模拟器包编译完成"
    say "模拟器调试包编译完成"
  fi
}

buildPackIOS(){
if [[ -d "${IOS_DIR}" ]]; then
    cp -R ${IOS_DIR}/ ./${PROJECT_NAME}_SDK/${INSTALL_DIR}/
    echo "✅真机包编译完成"
    say "真机编译完成"
  fi
}


INPUT_VALUE=${1}
case ${INPUT_VALUE} in
    all )
    buildPackAll
    ;;

    sim )
    buildPackSim
    ;;

    ios)
    buildPackIOS
    ;;
esac


if [[ -f "${PROJECT_NAME}.podspec" ]]; then
	rm -rf ${PROJECT_NAME}.podspec
fi

echo 'Pod::Spec.new do |s|
  s.name             = "WGBPackFramework"
  s.version          = "1.0.1"
  s.summary          = "framework组件"

  s.description      = <<-DESC
   组件化中间件,可插拔,无侵入 易于维护和卸载
                       DESC

  s.homepage         = "https://github.com/xxx"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "xxx" => "xxxx" }
  s.source           = { :file => "./", :tag => s.version.to_s }

  s.ios.deployment_target = "10.0"
  s.vendored_frameworks = "WGBPackFramework.framework"
  s.resource = "WGBPackFramework.framework/frameworkResource.bundle"
  s.frameworks = "UIKit","Foundation"

end
'>>${PROJECT_NAME}.podspec
say "生成pod依赖文件"
cp -a ${PROJECT_NAME}.podspec  ./${PROJECT_NAME}_SDK/
rm -rf ${PROJECT_NAME}.podspec
open ./

cp -a ./${PROJECT_NAME}_SDK/ ../TestPodDemo/MyFramework/
cd ../TestPodDemo
say "安装pod依赖"
pod install
say "打开依赖pod的demo项目"
open *.xcworkspace


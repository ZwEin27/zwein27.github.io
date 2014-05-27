---
layout: post
url: /Development/2014/02/19/ios-troubleshooting/index.html
title: "iOS Troubleshooting"
date: 2014-02-19 09:58:32 +0800
permalink: /Development/2014/02/19/ios-troubleshooting/
comments: true
category: Development
tags: iOS
keywords: Troubleshooting ios开发 debug 故障排除 问题解决
description: 记录iOS开发过程中遇到问题的解决方案
lang: zh
indexer: true
disqus-url: /_posts/2014/02/19/ios-troubleshooting.markdown
---


## XCODE Troubleshooting

### failed to get the task for process xxxxx

在XCODE5环境下，运行项目出现`failed to get the task for process xxx`

* 证书问题

原因: project和targets的证书都必须是开发证书，ADHOC的证书会出现此问题。
<!-- more -->
解决方案: project和targets的证书`使用开发证书`。

* code sign

把code sign由Distribution改成Developer。
(尚未遇到这个问题，网络上找到的，暂记录)

* 免证书真机调试

原因：XCODE5环境下免证书进行真机调试，每次新建项目都需要对项目进行配置。出现该问题可能的原因是项目配置不正确。

解决方案：

1)检查CODE SIGN是否都为`Don't Code Sign`

![dontcodesign](/images/blog/14-2-19_AM10_08-12.png)

2)检查run script脚本

![runscript](/images/blog/14-2-19_AM10_14-4.png)

Run Script脚本

<pre>
export CODESIGN_ALLOCATE=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate
if [ "${PLATFORM_NAME}" == "iphoneos" ] || [ "${PLATFORM_NAME}" == "ipados" ]; then
/Applications/Xcode.app/Contents/Developer/iphoneentitlements/gen_entitlements.py "my.company.${PROJECT_NAME}" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/${PROJECT_NAME}.xcent";
codesign -f -s "iPhone Developer" --entitlements "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/${PROJECT_NAME}.xcent" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/"
fi
</pre>


### Application windows are expected to have a root view controller at the end of application launch

使用XCODE5创建Empty项目运行后，控制台提示该错误。

解决方法：在项目AppDelegate.m文件中，注释didFinishLaunchingWithOptions()方法中的内容即可。

	
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	    // Override point for customization after application launch.
	    //self.window.backgroundColor = [UIColor whiteColor];
	    //[self.window makeKeyAndVisible];
	    return YES;
	}


### linker command failed with exit code 1 (use -v to see invocation)

添加第三方类库出现该错误提示

解决办法：

1）找到Build settings->Linking->Other Linker Flags，将此属性修改成-all_load，或者将此属性内容清空

2）在工作左边导航栏Target-->Build Phases-->compile Sources中，第三库库的所有.m文件都添加到里面即可

### Undefined symbols for architecture armv7s

根据网上资料

* armv6：iPhone 2G/3G，iPod 1G/2G
* armv7：iPhone 3GS/4/4s，iPod 3G/4G，iPad 1G/2G/3G
* armv7s：iPhone5

一般真机测试时，如果报armv7s错误，一般都是因为armv7s指令集是打开的，而之前一些引用库都是使用armv7s之前的指令集编译的(当这些引用的外部库使用armv7s指令集编译后，就不会出现该问题)。
解决办法如下1,2都可以：
1,[去掉armv7s指令集支持]xcode-->"Build Settings"-->"Valid Architectures"中把armv7s去掉(可能使程序无法适配iPhone5)。
2,[兼容armv7s]PROJECT-Build Setting，然后把Build Active Architecture Only的值设置为Yes。

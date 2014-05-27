---
layout: post
url: /Diary/2014/02/22/ios-note-13-open-source-library/index.html
title: "iOS 开发笔记 13 - 开源库"
date: 2014-02-22 20:30:41 +0800
permalink: /Diary/2014/02/22/ios-note-13-open-source-library/
comments: true
category: Development
tags: iOS
keywords: iOS Open Source 开源 代码库
description: iOS下的开源库收集笔记
lang: zh
indexer: true
published: false
disqus-url: /_posts/2014/02/22/ios-note-13-open-source-library.markdown
---


## 项目管理

### 项目依赖库管理工具 - CocoaPods

[CocoaPods](http://cocoapods.org/)，是一个项目依赖库的管理工具，使用它能够方便的在IOS下对第三方依赖进行部署和更新。

#### CocoaPods 的安装

安装CocoaPods需要确保本地有Ruby环境，MAC系统本身就有自带Ruby环境，控制台输入命令可以查看Ruby版本

	ruby -v
	
如果ruby版本不够新，可以使用以下命令更新

	gem update --system

为了防止被墙，，需要将原来的源位置修改为淘宝源

	$ gem sources --remove https://rubygems.org/
	$ gem sources -a http://ruby.taobao.org/
	
检查是否已经将源修改成功

	gem sources -l
	
配置和ruby环境后，输入命令安装CocoaPods

	sudo gem install cocoapods
	
#### CocoaPods的使用

##### 查找想要的第三方源是否存在

以JSONKit为例，终端输入

	pod search JSONKit

这条命令会查找是否存在你想要的依赖库，如果存在，选择匹配的项目，并注意图中标注，后面会用到

![images](/images/blog/2014/02/140222204121.png)

如果输入`pod search`命令后一直停在`Setting up CocoaPods master repo`,可以尝试：

	sudo rm -fr ~/.cocoapods/repos/master
	pod setup
	
等待一段时间，直到终端出现`Setup completed (read-only access)`

##### 配置Podfile

终端进入想要使用CocoaPods管理依赖库的项目的目录，注意是要和.xcodeproj在同一路径下

新建Podfile文件，并输入以下内容

	platform :ios, '6.0'
	pod 'JSONKit',       '~> 1.5pre'

终端输入以下命令进行安装

	pod install

安装完成后会出现.xcworkspace结尾的文件，以后都是用该文件打开项目。

打开.xcworkspace文件后就会看到CocoaPods自动为你下载了依赖库

##### 依赖库配置

如果想要更新或者添加依赖库，操作与添加类似，主要是使用`pod search 依赖库名称`和修改`Podfile`文件，然后使用`pod update`进行更新



## UI 库

### Sliding Menu

* [SWRevealViewController](https://github.com/John-Lluch/SWRevealViewController)
* [ViewDeck](https://github.com/Inferis/ViewDeck)
* [GHSidebarNav](https://github.com/Inferis/ViewDeck)
* [RNFrostedSidebar](https://github.com/rnystrom/RNFrostedSidebar)

### Flat UI

* [FlatUIKit](https://github.com/Grouper/FlatUIKit): 可参考 [Flat-UI](http://designmodo.github.io/Flat-UI/)
* [UI7Kit](https://github.com/youknowone/UI7Kit)
* [FlatUI](https://github.com/piotrbernad/FlatUI)
* [iPhone Flat Design UI](http://www.appdesignvault.com/iphone-flat-ui-design-patterns/)
* [UIColor-MLPFlatColors](https://github.com/EddyBorja/UIColor-MLPFlatColors)： 扁平化色块
* [UICustomizeKit](https://github.com/daltoniam/UICustomizeKit): 扁平化组件
* [FlatButtons](https://github.com/ijason/FlatButtons)
* [TiFlatUIKit](https://github.com/uchidak1124/TiFlatUIKit): 基于移动开发框架Titanium
* [FlatUIKit](https://github.com/daltoniam/FlatUIKit):扁平化组件，红色系




#### SWRevealViewController

教程：[How To Add a Slide-out Sidebar Menu in Your Apps](http://www.appcoda.com/ios-programming-sidebar-navigation-menu/)

项目地址：[SWRevealViewController](https://github.com/John-Lluch/SWRevealViewController)

### Video

[SCAudioVideoRecorder](https://github.com/rFlex/SCAudioVideoRecorder)

### Image

#### Face Identification
* [UIImageView-BetterFace](https://github.com/croath/UIImageView-BetterFace)： a UIImageView category to let the picture-cutting with faces showing better

#### Avatar Making
[AGMedallionView](https://github.com/arturgrigor/AGMedallionView)

#### Image Filter

[ DLCImagePickerController](https://github.com/gobackspaces/DLCImagePickerController)： 会用到[GPUImage](https://github.com/BradLarson/GPUImage)


### Menu

#### Alert Menu

* [RNGridMenu](https://github.com/rnystrom/RNGridMenu)：支持点击按钮或者长按界面弹出Menu菜单，并且背景模糊化处理
* [HMSideMenu](https://github.com/HeshamMegid/HMSideMenu)：界面右端显示和隐藏菜单按钮。


#### DropDown Menu

[VPPDropDown](https://github.com/vicpenap/VPPDropDown)



### Toolbar

[ABFullScrollViewController](https://github.com/andresbrun/ABFullScrollViewController): 为TableView等与滚动条相关的界面提供给的Toolbar，支持根据滚动的状态进行隐藏和显示


### Interactive

[InteractiveViewControllerTransitions](https://github.com/PeteC/InteractiveViewControllerTransitions): 交互界面，有两个View，点击第一个的图片会进入第二个显示详细信息，第一个View的图片会动态显示到第二个



### Share View

[REComposeViewController](https://github.com/romaonthego/REComposeViewController): 状态信息发布视图,地步弹出式，提供三种社交网络的风格选择。

[DDShareViewController](https://github.com/digdog/DDShareViewController):类似Facebook的状态发布

[FMFacebookPanel](https://github.com/flubbermedia/FMFacebookPanel):类似Facebook的状态发布

[DETweetComposeViewController](https://github.com/doubleencore/DETweetComposeViewController): 类似Twitter的状态发布







## Camera 摄像头类库

### ImagePicker

[DBCamera](https://github.com/danielebogo/DBCamera)

[DDExpandableButton](https://github.com/ddebin/DDExpandableButton)：Camera Button

[FaceCamViewer](https://github.com/ijason/FaceCamTest)

[DoImagePickerController](https://github.com/donobono/DoImagePickerController):从图片库中选择图片，支持多选和单选



### 滤镜相机Camera

### Video
[PBJVision](https://github.com/piemonte/PBJVision):类似vine的工具，支持触摸录像，残影。



## Mark

https://github.com/calebd/SimpleAuth
https://github.com/aporat/SocialAccounts
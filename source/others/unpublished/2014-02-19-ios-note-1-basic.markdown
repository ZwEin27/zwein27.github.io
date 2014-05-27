---
layout: post
url: /Development/2014/02/19/ios-note-1-basic/index.html
title: "iOS 开发笔记 1 - 基础"
date: 2014-02-19 21:14:55 +0800
permalink: /Development/2014/02/19/ios-note-1-basic/
comments: true
category: Development
tags: iOS
keywords: iOS Basic Develop 开发 基础 入门
description: iOS开发入门
lang: zh
indexer: true
disqus-url: /_posts/2014/02/19/ios-note-1-basic.markdown
---

## 学习资料

### 阅读书目

* [《马上着手开发 iOS 应用程序 (Start Developing iOS Apps Today)》](https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOSCh/chapters/Introduction.html)
* 《Your First iOS App》
* 《Your Second iOS App: Storyboards》
* 《Your Third iOS App: iCloud》
* 《iOS Technology Overview》
* 《iOS Human Interface Guidelines》
* 《Learning Objective-C: A Primer》和《Programming with Objective-C》
* 《iOS App Programming Guide》
* 《View Programming Guide for iOS》和《View Controller Programming Guide for iOS》
* 《Table View Programming Guide for iOS》

<!-- more -->

### 开发社区

* [CocoaChina](http://www.cocoachina.com/)

### 技术博客

* [Ryan's zone](http://blog.csdn.net/ryantang03/article/category/1073221)
* [刘伟Derick-IOS应用开发](http://blog.csdn.net/iukey/article/list/2)
* [容芳志专栏](http://blog.csdn.net/totogo2010/article/category/1155959)
* [M了个J](http://blog.csdn.net/q199109106q/article/category/1340820)

### 开源项目汇总

* [开源中国-IOS代码库](http://www.oschina.net/ios/codingList)
* [CocoaChina-开发者代码库](http://code.cocoachina.com/)
* [Code4App](http://code4app.com/)

waiting for more...

### 开发工具汇总

waiting for more...

#### XCode

##### 快捷键

* 快速切换XCode项目： cmd+～

## 基础概念

### XCode、Objective-C、Cocoa

* XCODE

iOS开发环境，笔者学习时使用的时XCODE5版本。类似于Visual Studio, Netbeans 或者 Eclipse之类的程序。

* Objective-C

iOS的开发语言， 是C语言的超集。

* Cocoa

包含一堆函数库，包含一些写好的现成的功能，方便使用者调用。



### iOS程序运行流程

#### mian.m 文件

iOS应用程序的主入口

main函数的两个参数为命令行参数，在ios开发中不会用到这些元素.包括这两个参数是为了与标准ANSI C保持一致

#### UIApplicationMain 函数

为应用程序提供主入口点，创建新的应用程序实例和它的委托。委托负责处理应用程序状态变更，并为那些变更提供响应。

#### UIViewController

启动和加载窗口后，应用程序委托退居幕后，几乎所有应用程序语义都转到UIViewController类的某个子类，应用程序委托通常不再发挥作用，除非应用程序将要结束，或者出现内存问题。

UIViewController继承了UIResponder，而UIResponder继承了NSObject，UIViewController是所有视图控制器的父类。

在MVC模式中，UIViewController扮演C（controller）的角色，控制视图以及模型的操作。

ViewController的简单生命周期：

* loadView：创建视图控制器（如果不是从.xib加载）
* viewDidLoad：视图已加载
* viewWillAppear：视图加载前运行
* viewWillDisappear：视图消失前（被关闭或覆盖）运行
* willRotateToInterfaceOrientation:duration：开始旋转时运行
* didRotateToInterfaceOrientation：旋转结束时运行

loadView和viewDidLoad的区别：
loadView在视图初始化的时候调用，应用开启后只调用一次
viewDidLoad在每次进入一个视图的时候都会调用

#### 运行流程

main() ---> 应用程序委托（AppDelegate） ----> 视图控制器（UIViewConstroller）





> 参考
> 
> [Ryan's zone](http://blog.csdn.net/tangren03/article/category/1073221/5)




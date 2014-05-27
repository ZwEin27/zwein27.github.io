---
layout: post
url: /Development/2014/02/20/ios-note-4-design-patterns/index.html
title: "iOS 开发笔记 4 - 设计模式"
date: 2014-02-20 07:36:04 +0800
permalink: /Development/2014/02/20/ios-note-4-design-patterns/
comments: true
category: Development
tags: iOS
keywords: iOS 设计模式 Design Pattern 单例 通知中心 MVC 协议 委托
description: iOS开发中涉及到的设计模式
lang: zh
indexer: true
disqus-url: /_posts/2014/02/20/ios-note-4-design-patterns.markdown
---


在代码中采用设计模式，有助于增加类和框架类的可再用性和扩展性。

[采用设计模式使您的应用程序合理化](https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOSCh/chapters/StreamlineYourAppswithDesignPatterns/StreamlineYourApps/StreamlineYourApps.html)
<!-- more -->

## 单例模式

单例模式是在实际项目开发中用到比较多的一种设计模式，设计原理是整个系统只产生一个对象实例，通过一个统一的方法对外提供这个实例给外部使用。

在Java中，构造单例一般将类的构造函数声明为private类型，然后通过一个静态方法对外提供实例对象，那么，在OC中，如何实现单例的，请看下面完整代码。

	
	@implementation Car
	
	//声明一个静态对象引用并赋为nil
	static Car *sharedInstance= nil;
	
	//声明类方法（+为类方法，也就是Java中的静态方法）
	+(Car *) sharedInstance
	{
	     if(!sharedInstance)
	     {
	          sharedInstance = [[self alloc] init];
	     }
	     return sharedInstance;
	}
	@end
	
	//覆盖allocWithZone：方法可以防止任何类创建第二个实例。使用synchronized()可以防止多个线程同时执行该段代码（线程锁）
	+（id）allocWithZone:(NSZone *) zone
	{
	     @synchronized(self)
	     {
	          if(sharedInstance == nil)
	          {
	               sharedInstance = [super allocWithZone:zone];
	               return sharedInstance;
	          }
	     }
	     return sharedInstance;
	}

到这里，OC中的单例就创建完成了，使用的话，直接类名调用类方法即可。


## 类别和协议

### 类别

扩展已存在类的内置功能（无需继承便可扩展类的功能）

类别可以扩展类之前不存在的一个属性

不能像继承那样给类别接口添加实例变量，而是要扩展一个类的行为

除了对现有类增加新的行为之外，类别还支持对自己构建的类把相关方法分组到多个单独文件中

在m文件中用匿名类别可以实现方法或属性的私有化

	//在import之后添加：
	interface 类名（）{
		私有化属性
	}


### 协议

协议定义了一个类与另一个类沟通的先验方式

它们包含一个方法列表，有的是可选的，有的是必须的。

协议中定义的方法包括一些操作响应和事件响应。

委托和数据源都是由协议产生的。

协议类似Java中的接口，定义了一组方法，遵循协议的类都认为同意满足这一组方法列表。

协议可以用来定义回调方法
（IOS委托和数据源都是用协议来实现的，UITableViewDelegate、UITableViewDatasource）

协议分为可选实现方法和必须实现方法，用关键字 @required 和 @optional 区分

判断一个类是否实现了协议的可选方法：

	if([self.client respondsToSelector : @selector(doSomething)])
	{
	     [self.client doSomething];
	}

## 委托：代表另一个对象

在委托中，一个称为委托的对象应另一个对象的请求，作为该对象的代表。

作出委托的对象，通常是框架模型。

在执行的某些时候，它会向其委托发送消息，告诉委托即将发生某些事件，并要求给它回应。

委托（通常是自定类的实例）实施供该消息调用的方法，并返回相应的值。通常该值是一个 Boolean 值，告诉作出委托的对象是否继续操作。



## 通知中心

通过通知，可以在一定的条件下触发响应的事件

类似于Android中的广播机制（Broadcase Receiver），接收到通知（广播）后，便可执行指定的方法。

通过NSNotificationCenter获取通知对象，注册并使用通知。

下面 以一个例子为例：

	UIApplication *application = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:application];

以上代码注册了一个通知

addObserver是接收通知的对象，通常为self

elector是接收到通知后要执行的操作，可以理解为操作事件

name是通知的名称，这里使用的是UIApplicationWillResignActiveNotification，意思是应用程序将要进入后台之前，object限定只接收来自哪些对象的通知，通常设为nil。

关于通知的响应可以在这里实现

	-(void)applicationWillResignActive:(NSNotification *)notification
	{
	
	}


> 参考
>
> [Ryan's zone](http://blog.csdn.net/tangren03/article/category/1073221/5)
>









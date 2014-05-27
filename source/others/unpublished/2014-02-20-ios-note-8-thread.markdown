---
layout: post
url: /Diary/2014/02/20/ios-note-8-thread/index.html
title: "iOS 开发笔记 8 - 线程"
date: 2014-02-20 14:20:36 +0800
permalink: /Diary/2014/02/20/ios-note-8-thread/
comments: true
category: Development
tags: iOS
keywords: iOS 线程
description: iOS开发的线程操作和管理
lang: zh
indexer: true
disqus-url: /_posts/2014/02/20/ios-note-8-thread.markdown
---

IOS中支持多线程操作

使用NSThread和NSInvocationOperation可以完成多线程功能。

多线程的功能主要是为了防止阻塞主线程的工作（主要是UI操作和显示），使一些耗时的的操作在另一个线程中完成，完成后可以通知主线程来进行UI上的更新。

多线程功能在实际开发中用的很多，最典型的就是网络请求和处理操作

下面主要来讨论一下Cocoa中的NSThread和NSInvocationOperation：
<!-- more -->
## NSThread

创建NSThread主要有两种方式：

1.使用类方法创建

	[NSThread detachNewThreadSelector:@selector(doInBackgroud) toTarget:self withObject:nil];

2.使用传统方式创建
	
	NSThread *thread = [[NSThreadalloc]initWithTarget:self selector:@selector(doInBackgroud)object:nil];
	[thread start];

两种方式的区别：

1.第一种方式会立即调用并执行线程，第二种必须调用start方法后才会开始执行线程，在此之前可以对线程进行一些设置，比如线程优先级等。第二种方式与Java中线程的使用类似。

2.使用类方法（Convenient Method）创建的线程不需要进行内存清理，而使用initWithTarget方法创建的线程需要当retainCount为0时调用release方法释放内存。

//在另一个线程中运行的方法

	-(void)doInBackgroud
	{
	    NSAutoreleasePool *releasePool = [[NSAutoreleasePoolalloc]init];
	    //do someting...
	    
	    [releasePool release];
	}


多线程中执行的方法必须自行进行内存管理，否则会出现警告信息。

运行程序可以看到打印信息：

2012-08-08 11:03:21.470 ThreadTest[518:f803] Thread is start...
2012-08-08 11:03:21.471 ThreadTest[518:1291b] Thread is running...
2012-08-08 11:03:24.471 ThreadTest[518:1291b] Thread is done…

完整代码如下：

	- (void)viewDidLoad
	{
	    [superviewDidLoad];
	    
	    NSLog(@"Thread is start...");
	    //使用类方法创建线程
	//  [NSThread detachNewThreadSelector:@selector(doInBackgroud) toTarget:self withObject:nil];
	    
	    //使用传统方式创建
	    NSThread *thread = [[NSThreadalloc] initWithTarget:self selector:@selector(doInBackgroud) object:nil];
	    [thread start];
	    [thread release];
	}
	     
	//在另一个线程中运行的方法
	-(void)doInBackgroud
	{
	    NSAutoreleasePool *releasePool = [[NSAutoreleasePool alloc] init];
	    
	    //do someting...
	    NSLog(@"Thread is running...");
	    [NSThread sleepForTimeInterval:3];
	    NSLog(@"Thread is done...");
	    
	    [releasePool release];
	}


## NSOperation

NSOperation是Cocoa中的一个抽象类，用来封装单个任务和代码执行一项操作

由于是抽象类，所以不能直接实例化使用，必须定义子类继承该抽象类来实现

比较常用的NSOperation的子类有NSInvocationOperation，另外，也可以自己继承NSOperation来实现线程的操作。

另外会使用到操作队列NSOperationQueue，它相当于一个线程队列或者可以叫做线程池，可以顺序执行队列中的操作，也可以设置队列中操作的优先级。


.h头文件

	#import <Foundation/Foundation.h>
	
	@interface MyTaskOperation : NSOperation
	
	@end

.m实现文件：

	#import "MyTaskOperation.h"
	
	@implementation MyTaskOperation
	
	//相当于Java线程中的run方法
	-(void)main
	{
	    //do someting...
	    NSLog(@"Thread is running...");
	    [NSThreadsleepForTimeInterval:3];
	    NSLog(@"Thread is done...");
	}
	@end

使用方法如下：

	//使用NSOperation子类来创建线程
	NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
	MyTaskOperation *myTask = [[MyTaskOperation alloc] init];
	[operationQueue addOperation:myTask];
	[myTask release];
	[operationQueue release];

运行输出结果跟上面的一样。

## NSInvocationOperation

NSOperation的子类NSInvocationOperation提供了一套简单的多线程编程方法，是IOS多线程编程中最简单的一种实现方式。直接看代码：


	//创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    //设置队列中最大的操作数
    [operationQueue setMaxConcurrentOperationCount:1];
    //创建操作（最后的object参数是传递给selector方法的参数）
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doInBackgroud) object:nil];
    //将操作添加到操作队列
    [operationQueue addOperation:operation];
    [operation release];
    [operationQueue release];


运行输出结果跟上面的一样。


> 参考
>
> [Ryan's zone](http://blog.csdn.net/ryantang03/article/details/7842903)
>
> 







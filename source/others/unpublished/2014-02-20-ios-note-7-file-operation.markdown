---
layout: post
url: /Development/2014/02/20/ios-note-7-file-operation/index.html
title: "iOS 开发笔记 7 - 文件操作"
date: 2014-02-20 10:13:32 +0800
permalink: /Development/2014/02/20/ios-note-7-file-operation/
comments: true
category: Development
tags: iOS
keywords: iOS File Operation 文件操作 沙盒
description: iOS文件操作笔记，包括对沙盒机制的讨论和基本的文件操作方法
lang: zh
indexer: true
disqus-url: /_posts/2014/02/20/ios-note-7-file-operation.markdown
---

## 沙盒机制

IOS中的沙盒机制（SandBox）是一种安全体系，它规定了应用程序只能在为该应用创建的文件夹内读取文件，不可以访问其他地方的内容。所有的非代码文件都保存在这个地方，比如图片、声音、属性列表和文本文件等。

1.每个应用程序都在自己的沙盒内

2.不能随意跨越自己的沙盒去访问别的应用程序沙盒的内容

3.应用程序向外请求或接收数据都需要经过权限认证

<!-- more -->

查看模拟器的沙盒文件夹在Mac电脑上的存储位置，首先，这个文件夹是被隐藏的，所以要先将这些文件显示出来，打开命令行：
	
	//显示Mac隐藏文件的命令：
	defaults write com.apple.finder AppleShowAllFiles -bool true
	
	//隐藏Mac隐藏文件的命令：
	defaults write com.apple.finder AppleShowAllFiles -bool false

然后重新启动Finder，点击屏幕左上角苹果标志——强制退出——选择Finder然后点击重新启动，这个时候在重新打开Finder就可以看到被隐藏的文件了。


还有一种比较简单的办法就是直接点击Finder图标右键——前往文件夹——输入/Users/your username/Library/Application Support/iPhone Simulator/ ,然后确认就可以了。your username是你本机的用户名

然后按下图进入相应的文件夹，就可以到模拟器的沙盒文件目录了.

接着进入一个模拟器版本, 然后可以看到Applications下面存放的就是模拟器中所装的开发的应用程序，随便进入一个后可以看到，一个沙盒中包含了四个部分，如图所示:

![image](/images/blog/14-2-20_AM10_23-9.png)


### 沙盒中的目录操作

#### 获取沙盒中的目录

	//获取根目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"Home目录：%@",homePath);
    
    //获取Documents文件夹目录,第一个参数是说明获取Doucments文件夹目录，第二个参数说明是在当前应用沙盒中获取，所有应用沙盒目录组成一个数组结构的数据存放
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [docPath objectAtIndex:0];
    NSLog(@"Documents目录：%@",documentsPath);
    
    //获取Cache目录
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"Cache目录：%@",cachePath);
    
    //Library目录
    NSArray *libsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libsPath objectAtIndex:0];
    NSLog(@"Library目录：%@",libPath);
    
    //temp目录
    NSString *tempPath = NSTemporaryDirectory();
    NSLog(@"temp目录：%@",tempPath);

输出结果：

	2012-08-03 11:10:24.325 SandBoxTest[12549:f803] Home目录：/Users/Ryan/Library/Application Support/iPhone Simulator/5.1/Applications/A6B99E5A-E2C7-46E9-867A-4E7619F0DA45
	
	2012-08-03 11:10:24.325 SandBoxTest[12549:f803] Documents目录：/Users/Ryan/Library/Application Support/iPhone Simulator/5.1/Applications/A6B99E5A-E2C7-46E9-867A-4E7619F0DA45/Documents
	
	2012-08-03 11:10:24.326 SandBoxTest[12549:f803] Cache目录：/Users/Ryan/Library/Application Support/iPhone Simulator/5.1/Applications/A6B99E5A-E2C7-46E9-867A-4E7619F0DA45/Library/Caches
	
	2012-08-03 11:10:24.326 SandBoxTest[12549:f803] Library目录：/Users/Ryan/Library/Application Support/iPhone Simulator/5.1/Applications/A6B99E5A-E2C7-46E9-867A-4E7619F0DA45/Library
	
	2012-08-03 11:10:24.326 SandBoxTest[12549:f803] temp目录：/var/folders/7z/1wj5h8zx7b59c02pxmpynd500000gn/T/
	
真机测试：

	2012-06-17 14:25:47.059 IosSandbox[4281:f803] /var/mobile/Applications/3B8EC78A-5EEE-4C2F-B0CB-4C3F02B996D2
	
可见，真机上的目录是/var/mobile/Applications/这个目录下的，和模拟器不一样。这个是Home目录，其他的子目录和模拟器一样。




#### 在Documents里创建目录

	 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];  
    NSLog(@"documentsDirectory%@",documentsDirectory);  
    NSFileManager *fileManager = [NSFileManager defaultManager];  
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];  
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
#### 在test目录下创建文件

接着上面的代码 testPath 要用stringByAppendingPathComponent拼接上你要生成的文件名，比如test00.txt。这样才能在test下写入文件。

testDirectory是上面代码生成的路径哦，不要忘了。

往test文件夹里写入三个文件，test00.txt ,test22.txt,text.33.txt。内容都是写入内容，write String。

实现代码如下：

	    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test00.txt"];  
    NSString *testPath2 = [testDirectory stringByAppendingPathComponent:@"test22.txt"];  
    NSString *testPath3 = [testDirectory stringByAppendingPathComponent:@"test33.txt"];  

    
    NSString *string = @"写入内容，write String";
    [fileManager createFileAtPath:testPath contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath2 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath3 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];



#### 获取目录中的所有文件名

两种方法获取：subpathsOfDirectoryAtPath 和 subpathsAtPath


	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];  
    NSLog(@"documentsDirectory%@",documentsDirectory);  
    NSFileManager *fileManage = [NSFileManager defaultManager];  
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];  
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: myDirectory error:nil]; 
    NSLog(@"%@",file);  
    NSArray *files = [fileManage subpathsAtPath: myDirectory ]; 
    NSLog(@"%@",files);
    

获取上面刚才test文件夹里的文件名

打印结果：

	2012-06-17 23:23:19.684 IosSandbox[947:f803] fileList:(
	    ".DS_Store",
	    "test00.txt",
	    "test22.txt",
	    "test33.txt"
	)
	2012-06-17 23:23:19.686 IosSandbox[947:f803] fileLit(
	    ".DS_Store",
	    "test00.txt",
	    "test22.txt",
	    "test33.txt"
	)
两个方法都可以，隐藏的文件也打印出来了。

#### 使用 FileManager 操作当前目录

	//创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    
    NSString * fileName = @"testFileNSFileManager.txt";
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"hello world",@"hello world1", @"hello world2",nil];
    
    [fileManager createFileAtPath:fileName contents:array attributes:nil];
    
    //删除文件    
    [fileManager removeItemAtPath:fileName error:nil];

### 沙盒中数据读写

#### 向目录里面创建文件

	NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [docPath objectAtIndex:0];
    //写入文件
    if (!documentsPath) {
        NSLog(@"目录未找到");
    }else {
        NSString *filePaht = [documentsPath stringByAppendingPathComponent:@"test.txt"];
        NSArray *array = [NSArray arrayWithObjects:@"Title",@"Contents", nil];
        [array writeToFile:filePaht atomically:YES];
    }



#### 读取沙盒中文件的内容

	//读取文件
	NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString *documentsPath = [docPath objectAtIndex:0];
	NSString *readPath = [documentsPath stringByAppendingPathComponent:@"test.txt"];
	NSArray *fileContent = [[NSArrayalloc] initWithContentsOfFile:readPath];
	NSLog(@"文件内容：%@",fileContent);

输出结果如下：

	2012-08-03 11:26:53.594 SandBoxTest[12642:f803] 文件内容：(
	    Title,
	    Contents
	)

#### 混合数据的读写

用NSMutableData创建混合数据，然后写到文件里。并按数据的类型把数据读出来

##### 写入数据：

    NSString * fileName = @"testFileNSFileManager.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    //待写入的数据
    NSString *temp = @"nihao 世界";
    int dataInt = 1234;
    float dataFloat = 3.14f;
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[temp dataUsingEncoding:NSUTF8StringEncoding]];   
    //将其他数据添加到缓冲中
    [writer appendBytes:&dataInt length:sizeof(dataInt)];
    [writer appendBytes:&dataFloat length:sizeof(dataFloat)];  
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];
    
##### 读取写入的数据：

	 //读取数据：
    int intData;
    float floatData = 0.0;
    NSString *stringData;
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    stringData = [[NSString alloc] initWithData:[reader subdataWithRange:NSMakeRange(0, [temp length])]
                                   encoding:NSUTF8StringEncoding];
    [reader getBytes:&intData range:NSMakeRange([temp length], sizeof(intData))];
    [reader getBytes:&floatData range:NSMakeRange([temp length] + sizeof(intData), sizeof(floatData))];
    NSLog(@"stringData:%@ intData:%d floatData:%f", stringData, intData, floatData);




> 参考
>
> [Ryan's zone](http://blog.csdn.net/ryantang03/article/details/7830996)
>
> iOS学习之iOS沙盒(sandbox)机制和文件操作  [(一)](http://blog.csdn.net/totogo2010/article/details/7669837)  [(二)](http://blog.csdn.net/totogo2010/article/details/7670417)  [(三)](http://blog.csdn.net/totogo2010/article/details/7671144)





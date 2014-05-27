---
layout: post
url: /Development/2014/02/20/ios-note-5-data/index.html
title: "iOS 开发笔记 5 - 数据"
date: 2014-02-20 07:51:13 +0800
permalink: /Development/2014/02/20/ios-note-5-data/
comments: true
category: Development
tags: iOS
keywords: iOS Data 数据
description: iOS开发中有关数据存储方面的内容
lang: zh
indexer: true
disqus-url: /_posts/2014/02/20/ios-note-5-data.markdown
---

## NSUserDefaults (用户首选项)

用户首选项是用来保存和记录用户在操作应用的过程做做出的一些选择或设置。

类似Android开发中的SharedPreference，可以存储一些数据，但基本都是简单类型的数据

主要作用都是存储一些用户设置数据，比如是否是首次登陆，就可以设置一个布尔类型的变量，设值为true或false。
<!-- more -->
### NSUserDefaults中的方法

* **standardUserDefaults**: 创建共享默认设置对象的类方法（Java中的静态方法，单例）
* **objectForKey**: 返回键对象的实例方法
* **setObject**: forKey：以指定的键设置值的实例方法

### 基本用法

#### 用户首选项的使用

新建一个工程，然后在 ViewController.m 中添加如下代码


	- (void)viewDidLoad
	{
	    [super viewDidLoad];
	    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
	    [myDefaults setObject:@"Hello" forKey:@"defaultKey"];
	    
	    NSLog(@"The value is %@",[myDefaults objectForKey:@"defaultKey"]);
	}

编译运行结果如下：

	NSUserDefaultsTest[3007:f803] The value is Hello

这样我们实现了NSUserDefaults的基本使用


NSUserDefaults有一个基本特点就是，数据是保存在程序**全局**中的，所以当退出程序后下次再进来时，数据还是存在的，这样就起到了保存用户操作数据的功能。




#### 偏好设置的使用

##### bundle

首先来熟悉一下bundle

bundle的意思是应用程序束的意思，在IOS开发中，存在三种类型的bundle，分别是框架bundle、应用程序bundle和设置bundle。

另外还有一种解释就是Xcode让您能够将多个文件组合成有机的整体，这就叫bundle。

实际上，bundle就是一个目录，或者叫包。

bundle的优点在于它能不露痕迹的存储文件的多个版本，并在特定的条件下使用正确的版本。

我们平常接触比较多的就是应用程序bundle，当编译运行程序在iphone或ipad上时，就创建了应用程序bundle。



###### 新建一个 Settings Bundle



首先新建一个文件，新建时选择Resources，然后选择Settings Bundle, 这样就建立了一个设置首选项

![image](/images/blog/14-2-20_AM8_04-12.png)

运行后，模拟器的中按HOME键，打开设置，可以看到如下界面：

![image](/images/blog/14-2-20_AM8_25-5.png)

###### Settings Bundle 控件设置

默认生成的设置项中的控件包括：Group分组，文本框，Slider，开关控件

设置项中能够使用的控件：

* **文本框**:	PSTextFieldSpecifier
* **文字**:	PSTitleValueSpecifier
* **开关控件**:	PSToggleSwitchSpecifier
* **Slider**:	PSSliderSpecifier
* **Multivalue**:	PSMultiValueSpecifier
* **Group**:	PSGroupSpecifier
* **子面板**:	PSChildPaneSpecifier.

###### 编辑设置项文件

展开Settings.bundle，其中包含一个Root.plist。

Settings程序中的显示项就是从Root.plist中获取的。

###### Settings 的读取和写入

主要是通过`NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];`

代码获取设置项的NSUserDefaults值，然后通过key获取设置的内容和保存设置内容

如果将Settings的读取和写入操作以两个按键触发的方式来实现，则实现代码可以如下所示：

	// 从Settings中读取设置
	- (IBAction)getSettings:(id)sender {
	    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	    username.text =  [defaults objectForKey:@"username"];
	    selectedAihao = [defaults objectForKey:@"aihao"];
	    NSLog(@"aihao:%@",selectedAihao);
	    NSInteger aihaoIndex = [aihaoValues indexOfObject:selectedAihao];
	    [pickerView selectRow:aihaoIndex inComponent:0 animated:YES];
	    [level setValue:[defaults integerForKey:@"levelState"]];
	}
	
	//保存设置到Settings
	- (IBAction)setSettings:(id)sender {
	    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	    [defaults setValue:username.text forKey:@"username"];
	    NSInteger aihaoIndex = [aihaoTitles indexOfObject:selectedAihao];
	
	    [defaults setValue:[aihaoValues  objectAtIndex:aihaoIndex] forKey:@"aihao"];
	    [defaults setInteger:level.value forKey:@"levelState"];
	    UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"偏好设置"
							  message:@"偏好设置已经保存！"
							  delegate:nil 
							  cancelButtonTitle: @"完成" 
							  otherButtonTitles:nil];
		[alert show]; 
	}

具体举例可以参考：[iOS开发之iOS程序偏好设置(Settings Bundle)的使用](http://blog.csdn.net/totogo2010/article/details/7698166)


### 使用限制

并不是所有的东西都能存入NSUserDefaults。

NSUserDefaults只支持： NSString, NSNumber, NSDate, NSArray, NSDictionary.

解决方法：让这个自定义类实现<NSCoding>协议中两个方法

	- (id) initWithCoder: (NSCoder *)coder
	- (void) encodeWithCoder: (NSCoder *)coder

（OC的协议protocol就是java的接口interface，就是C++的纯虚函数），然后把该自定义的类对象编码到NSData中，再从NSUserDefaults中进行读取。

实例代码：

假设有这样一个简单的类对象：

	@interface BusinessCard : NSObject <NSCoding>{
		NSString *_firstName;
		NSString *_lastName;
	}
	@property (nonatomic, retain) NSString *_firstName;
	@property (nonatomic, retain) NSString *_lastName;
	@end;
	
	@implementation BusinessCard
	@synthesize _firstName, _lastName;
	- (void)dealloc{
		[_firstName release];
		[_lastName release];
		[super dealloc];
	}
	- (id) initWithCoder: (NSCoder *)coder
	{
		if (self = [super init])
		{
			self._firstName = [coder decodeObjectForKey:@"_firstName"];
			self._lastName = [coder decodeObjectForKey:@"_lastName"];
		}
		return self;
	}
	- (void) encodeWithCoder: (NSCoder *)coder
	{
		[coder encodeObject:_firstName forKey:@"_firstName"];
		[coder encodeObject:_lastName forKey:@"_lastName"];
		
	}
	
	@end

在存取时通过NSData做载体：

	BusinessCard *bc = [[BusinessCard alloc] init];
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:bc];
	[ud setObject:udObject forKey:@"myBusinessCard"];
	[bc release];
	udObject = nil;
	udObject = [ud objectForKey:@"myBusinessCard"];
	bc = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;


以上的代码时由另一个程序中截取的，没有测试过，但是可以通过这样理解。

如果一个自定义类中由另一个自定义类对象，那么所有嵌套的类都要实现<NSCoding>。




## iOS 中 的SQLite

SQLite是MySQL的简化版，更多的运用与移动设备或小型设备上。

SQLite的优点是具有可移植性，它不需要服务器就能运行，同时，它也存在一些缺陷. 

首先，没有提供简单的数据库创建方式，必须手工创建数据库，其次，SQLite没有面向对象接口，必须使用依赖于C语言代码的API。相对于OC，这套API既不那么优雅，也更难使用。

但相比于用文件进行存储，还是更推荐使用SQLite进行数据存储。

在Android也有类似的使用。

### iOS SQLite 数据库的操作步骤

* 加入sqlite开发库`libsqlite3.dylib`
* 新建或打开数据库
* 创建数据表
* 插入数据
* 查询数据并打印
 
具体实例可以参考：[iOS学习之sqlite的创建数据库,表,插入查看数据](http://blog.csdn.net/totogo2010/article/details/7702207)

### SQLite API 第三方封装库 FMDB

针对IOS的SQlite API封装的第三方库[FMDB](https://github.com/ccgus/fmdb)，对SDK中的API做了一层封装，使之使用OC来访问，使用方便而且更熟悉。

具体实例可以参考：[SQLite3第三方库之FMDB](http://blog.csdn.net/ryantang03/article/details/7875464)



## Core Data

Core Data是iOS5之后才出现的一个框架，它提供了对象-关系映射(ORM)的功能

既能够将OC对象转化成数据，保存在SQLite数据库文件中，也能够将保存在数据库中的数据还原成OC对象。

在此数据操作期间，我们不需要编写任何SQL语句，这个有点类似于著名的Hibernate持久化框架，不过功能肯定是没有Hibernate强大的。

具体实例可以参考：[Core Data入门](http://blog.csdn.net/q199109106q/article/details/8563438)

### 模型文件

在Core Data，需要进行映射的对象称为实体(entity)，而且需要使用Core Data的模型文件来描述app中的所有实体和实体属性。

### NSManagedObject

通过Core Data从数据库取出的对象，默认情况下都是NSManagedObject对象

NSManagedObject的工作模式有点类似于NSDictionary对象，通过键-值对来存取所有的实体属性

	setValue:forKey:存储属性值(属性名为key)
	valueForKey:获取属性值(属性名为key)

### 开发步骤总结

1.初始化NSManagedObjectModel对象，加载模型文件，读取app中的所有实体信息

2.初始化NSPersistentStoreCoordinator对象，添加持久化库(这里采取SQLite数据库)

3.初始化NSManagedObjectContext对象，拿到这个上下文对象操作实体，进行CRUD操作


## 问题积累

* [iOS 开发如果涉及数据和表的持久化，Core Data 比 SQLite 更好吗？](http://www.zhihu.com/question/20809133)


> 参考
>
> [Ryan's zone](http://blog.csdn.net/tangren03/article/category/1073221/5)
>
> [chyroger的专栏](http://blog.csdn.net/chyroger/article/details/5785297)
>
> [容芳志专栏](http://blog.csdn.net/totogo2010)
>
> [Core Data 编程指南](http://www.cocoachina.com/iphonedev/sdk/2010/1126/2397.html)
>
> [Core Data入门](http://blog.csdn.net/q199109106q/article/details/8563438)











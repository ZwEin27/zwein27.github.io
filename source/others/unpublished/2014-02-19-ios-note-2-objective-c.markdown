---
layout: post
url: /Development/2014/02/19/ios-note-2-objective-c/index.html
title: "iOS 开发笔记 2 - Objective-C"
date: 2014-02-19 21:45:53 +0800
permalink: /Development/2014/02/19/ios-note-2-objective-c/
comments: true
category: Development
tags: iOS
keywords: Objective-C iOS Note 开发 ios
description: iOS开发， Objective-C 学习笔记
lang: zh
indexer: true
disqus-url: /_posts/2014/02/19/ios-note-2-objective-c.markdown
---

## Objective-C 基础

### 什么是Objective-C

Objective-C 是一门基于C的面向对象语言，是C语言的一个超集，同时具有C语言的特征。

[Objective-C 官方教程](https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOSCh/chapters/WriteObjective-CCode/WriteObjective-CCode/WriteObjective-CCode.html)
<!-- more -->
#### id 类型

Objective-C有一种比较特殊的数据类型是id。你可以把它理解为“随便”。
 
在Objective-C里，一切东西都是指针形式保存，你获取到的就是这个对象在内存的位置。那么id就是你知道这个位置，但是不知道里面是啥的时候的写法。

<!-- more -->

#### NSArray数组

比如一个数组NSArray，这种数组里面可以保存各种不同的对象，比如这个数组里：

	myArray <—-|
 
                       0: (float) 234.33f
                       1: @”我是个好人”
                       2: (NSImage *)  (俺的美图)
                       3: @”我真的是好人”

这是一个由4个东西组成的数组，这个数组包括一个浮点数，两个字符串和一个图片。

#### BOOL，YES，NO

可以认为YES表示C#或者Java里的true，NO表示false。

而实际上YES是1，NO是0，BOOL本身就是个char。

#### IBOutlet、IBAction

这两个东西其实在语法中没有太大的作用。

如果你希望在Interface Builder中能看到这个控件对象，那么在定义的时候前面加上IBOutlet，在IB里就能看到这个对象的outlet

如果你希望在Interface Builder里控制某个对象执行某些动作，就在方法前面加上(IBAction)。
 
而这两个东西实际上和void是一样的。

#### nil

在Objective-C里代表NULL（空），表示空指针。

#### 字符串中的@”字符串”和”字符串”

”字符串”是C的字符串，@”"是把C的字符串转成NSString的一个简写.

在需要NSString的地方才需要这个转化,例如NSLog里面.

在需要C string的地方,还是用”字符串”的.

**另外,@”"这个转换是不支持中文的.例如NSLog(@”字符串”); 是一定输出不了中文的.**


#### strong和weak关键字

strong和weak关键字是IOS 5中新增的

##### strong

用来修饰强引用的属性

	@property (strong) SomeClass * aObject; 

对应原来的 

	@property (retain) SomeClass * aObject; 和 @property (copy) SomeClass * aObject; 

##### weak

用来修饰弱引用的属性；

	@property (weak) SomeClass * aObject; 

对应原来的 

	@property (assign) SomeClass * aObject; 

##### 其他

__weak, __strong 用来修饰变量，此外还有 __unsafe_unretained, __autoreleasing 都是用来修饰变量的。

	__strong 是缺省的关键词。
	__weak 声明了一个可以自动 nil 化的弱引用。
	__unsafe_unretained 声明一个弱应用，但是不会自动nil化，也就是说，如果所指向的内存区域被释放了，这个指针就是一个野指针了。
	__autoreleasing 用来修饰一个函数的参数，这个参数会在函数返回的时候被自动释放。




### Objective-C 的类和对象

#### 相关文件及其关系

* .h 文件

头文件。头文件包含类、类型、函数和常量声明。

* .m 文件

实现文件。具有此扩展名的文件可以同时包含 Objective-C 代码和 C 代码。有时也称为源文件。

* .mm 文件

实现文件。具有此扩展名的实现文件，除了包含 Objective-C 代码和 C 代码以外，还可以包含 C++ 代码。仅当您实际引用您的 Objective-C 代码中的 C++ 类或功能时，才使用此扩展名。

* 关系

当您想要在源代码中包括头文件时，需要在头文件或源文件的前几行之中，指定一个导入 (#import) 指令

（#import）指令类似于 C 的 #include 指令，不过前者确保同一文件只被包括一次。

如果您要导入框架的大部分或所有头文件，请导入框架的包罗头文件 (umbrella header file)，它具有与框架相同的名称。



#### 类的定义、实现、初始化

<pre>
	//声明类接口，继承NSObject对象（该对象是OC中所有类的顶级父类，所有类都继承于它）
    @interface ClassName ：NSObject 
    {
    	//成员变量声明
    	int count;
    	id	data;
    	NSString* name;
    }
          //方法声明
          +（void）function；//类方法，不需要实例化对象就可以调用的方法
          - （void）function2 ：（NSString *）arg；//成员方法，必须通过实例化的对象调用
    @end

     //实现类
    @imlementation ClassName
          //成员变量初始化和方法的定义
    @end
</pre>

对象的初始化：
	
	ClassName *obj = [[ClassName alloc] init]
	
OC中以消息机制传递信息，发送alloc消息给类分配内存空间，发送init消息生成对象，指针指向对象本身。

初始化方类似于在Java中
	
	ClassName obj = ClassName.alloc().init();

alloc()为类ClassName的类方法（即静态方法，不需要实例化，直接通过类名即可调用）
该方法返回一个ClassName类的实例

init()方法，即ClassName类实例化后得到的对象所执行的方法

在Java中，可以这样表示

	ClassName className = ClassName.alloc();
	className = className.init();


#### 类中的方法

* 方法的基本形式

(方法的数据类型) 函数名: (参数1数据类型) 参数1的数值的名字 参数2的名字: (参数2数据类型) 参数2值的名字 …. ;

* 方法举例

声明一个方法

	
	-(void) setKids: (NSString *)myOldestKidName secondKid: (NSString *) mySecondOldestKidName thirdKid: (NSString *) myThirdOldestKidName;

实现这个方法
	
	-(void) setKids: (NSString *)myOldestKidName secondKid: (NSString *) mySecondOldestKidName thirdKid: (NSString *) myThirdOldestKidName{
		大儿子 = myOldestKidName;
		二儿子 = mySecondOldestKidName;
		三儿子 = myThirdOldestKidName;
	}

调用这个方法
	
	Kids *myKids = [[Kids alloc] init];
	[myKids setKids: @”张大力” secondKid: @”张二力” thirdKid: @”张小力”];
	
调用方法类似的Java代码

	Kids myKids = new Kids();
	myKids.setKids (“张大力”, “张二力”, “张小力”);
	

#### 属性

##### 支持点表示法

	myTableViewCell.textLabel.text = @"hello" 等价于 [[myTableViewCell textLabel] setText:@"hello"];


##### 使用属性生成器 property

	在h文件中声明： @property int year
	在m文件中合成生成器：@synthesize year
	使用 obj.year = 1999 相当于调用了 [obj setYear:1999];

##### 自定义取值方法和赋值方法（getter and setter）

     -（int）year
     {
          return year;
     }

     - (void) setYear : (int) newYear
     {
          //此处添加了一些基本的内存管理方法，保留新的值，释放以前的值
          if(newYear != year)
          {
               [year release];
               year = [newYear retain];
          }
     }

##### 自定义Setter和Getter方法的名称

     @property(getter = isExist,setter = setExist:) BOOL exist;
     @synthesize exist;
     
使用过程中既可以使用新定义的方法名，也可以使用以前的方法（点表示法）
     
##### 属性的特性 readwrite readonly assign retain copy nonatomic

* assign：默认行为，使用@property int year就使用了assign行为，就是给实例变量赋了一个值
* retain：实现了两个功能，一个是保留了赋值时传递的对象，其次是赋值前释放了以前值，使用retain可以实现上面讨论的内存管理的优点，使用时加上 @property （retain）int year；
* copy：发送一条复制的消息给被传递的对象，保留它，并释放任何以前的值；
* nonactomic：非原子访问器，加上后可以提升访问速度，但当两个线程同时修改同一个属性时就会出现问题，原子属性可以保证属性在被一个线程使用时不被另一个线程访问，不存在atomic关键字，默认情况下，所有方法都是自动合成的。（类似与java中的线程锁机制synchronized）
* readwrite：可读写     
* readonly：只读


### Foundation 框架

#### 简称对应内容

*  CF 代表Core Foundation (Cocoa)
*  CA 代表Core Animation
*  CG 代表Core Graphics
*  UI 代表iPhone的User Interface

（欢迎补充）

#### 输出函数 NSlog 和CFShow

##### NSlog

格式化占位符

根据不同的输出格式输出不同的值
	
	%@ 对象
	%d, %i 整数
	%u   无符整形
	%f 浮点/双字
	%x, %X 二进制整数
	%o 八进制整数
	%zu size_t
	%p 指针
	%e   浮点/双字 （科学计算）
	%g   浮点/双字
	%s C 字符串
	%.*s Pascal字符串
	%c 字符
	%C unichar
	%lld 64位长整数（long long）
	%llu   无符64位长整数
	%Lf 64位双字
	
	

NSLog定义在NSObjCRuntime.h中，如下所示：

	void NSLog(NSString *format, …);

调用方式举例：

	
	NSLog (@”this is a test”);
	NSLog (@”string is :%@”, string);
	NSLog (@”x=%d, y=%d”, 10, 20);
	NSlog（@“The result is %d”,intNum）; 
	
错误的举例：

	int i = 12345;
	NSLog( @”%@”, i );


错误原因:  %@需要显示对象，而int i明显不是一个对象，要想正确显示，要写成：
int i = 12345;
NSLog( @”%d”, i );

##### CFShow

CFShow发送description给它显示的对象

CFShow打印的信息不会显示时间戳，NSLog会显示

CFShow不需要格式字符串，它只能用于对象`CFShow(obj);`

#### NSString (字符串类)

按格式生成

	[NSString stringWithFormat:@"The result is %@",5];

得到字符串长度
	
	myString.length

将字符串写入文件

	NSString *myString = @“hello world”；
	NSError *error；
	//NSHomeDirectory()返回的字符串指向应用程序沙盒的路径
	//Cocoa中，大多数文件访问例程都提供了一个原子选项，将原子参数设为YES，Iphone将文件写到一个临时辅助位置，然后就地重命名，使用原子写入可以使文件避免损坏。
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/file.txt"];  
	if(![myString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error])  
	{  
	     NSLog(@"Error writing to file:%@",[error localizeDescription]);  
	     return;  
	}  
	
从文件读取字符串

	NSString *inString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if(!inString)
	{
	     NSLog(@"Error writing to file:%@",[error localizeDescription]);
	     return;
	}
	
按指定符号切割字符串

	//切割结果为数组
	NSArray *array = [myString componentSeparatedByString:@" "];

字符串比较

	[s1 isEqualToString:s2];

将字符串转换成数字

	[s intValue];
	[s floatValue];
	[s boolValue];
	[s doubleValue];


#### 日期和时间 NSDate

	NSDate *date = [NSDate date]
	
使用线程使程序休眠一段时间

	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5.0f];

格式化时间

	NSDateFormatter *formatter = [[[NSDateFormatter alloc]init] autorelease];
	formatter.dateFormater = @"MM/dd/YY HH:mm:ss";
	NSString *timestamp = [formatter stringFromDate:[NSDate date]];

#### 集合

##### 数组 NSArray

	NSArray *array = [NSArray arrayWithObjects:@"one",@"two",nil];
	[array count];
	[array objectAtIndex:0];

##### 字典 NSDictionary

	NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
	[dict setObject:@“A” forKey:@"a"];
	
	取值：[dict objectForKey:@“a"];
	
	数量：[dict count];
	
	索引：[dict allKeys];

##### URL

	NSURL *url = [NSURL URLWithString : urlPath];

##### NSData

类似于缓存类

	[[NSData dataWithContentsOfURL:url] length];
	NSMutableData  （可变缓存类）
	appendData，追加新信息

##### 文件管理 NSFileManager

	NSFileManager *fm  = [NSFileManager defaultManager];

### 内存管理

在IOS5.0以后Apple增加了ARC机制（Automatic Reference Counting）

在OC中，每个对象都有一个保留计数，创建时每个对象都有一个初始值为1的保留计数，释放时，保留计数都为0

#### 创建自动释放的对象

要求以一个方法创建对象时，以自动释放的形式返回该对象是一个很好的编程实践
	
	+（Car *）car
	{
	     Car *myCar = [[Car alloc] init];
	     return [myCar autorelease];
	}
	
#### 创建已保留属性

	@property （retain）NSArray *colors；

synthesize创建后，自动保留该对象，如果该对象被重新赋值，前面的值将被自动释放	

#### 创建对象的其他方式

一般规则：通过alloc、new、create、copy的任意方法构建一个对象，就必须承担释放该对象的责任，和类方法不同，带这些字样的方法一般不会返回自动释放的对象

#### 释放对象

释放属性：`self.year = nil；`

会调用OC合成的自定义赋值方法，并释放以前赋值给该属性的任意对象

释放实例变量（非属性）：`[age release]; `

实例变量在对象生命周期内，随时可以指向一个保留计数+1的对象，必须释放当前赋值给age的任意对象，从而将计数置为0；
	




> 参考
>
> [Ryan's zone](http://blog.csdn.net/tangren03/article/category/1073221/5)
>
> [Objective-C语法快速参考](http://www.cocoachina.com/b/?p=122)






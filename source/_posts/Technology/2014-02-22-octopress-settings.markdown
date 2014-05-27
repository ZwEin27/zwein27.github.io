---
layout: post
url: /Technology/2014/02/22/octopress-settings/index.html
title: "Octopress Settings"
date: 2014-02-22 10:56:34 +0800
permalink: /Technology/2014/02/22/octopress-settings/
comments: true
category: Technology
tags: Octopress
keywords: Octopress
description: 使用 Octopress 搭建Blog的一些功能配置
lang: zh
indexer: true
disqus-url: /_posts/2014/02/22/octopress-settings.markdown
---


## Post Settings

### 截图配置

使用Octopress进行博客编写，截图是一件麻烦的事情，未配置的情况下，添加一个截图需要：

* 使用截图工具进行截图
* 将截图放置在blog中的图片目录
* 获取保存的截图地址
* 使用octopress的图片标签进行图片插入

o(╯□╰)o...单就这个方式来说，一点都不优雅，需要花费好多时间

下面将对我在MAC系统上为方便截图进行的配置。

<!-- more -->

#### 使用系统截图工具Screencapture

`ScreenCapture` 是MAC系统自带的截图工具，支持快捷键和shell激活。

这里主要使用Shell脚本激活的方式进行截图。

##### Screencapture 快捷键

* Shift+Command+3  截取全屏幕至桌面
* Shift+Command+4  截取部分屏幕至桌面
* Shift+Command+4+空格 截取窗口或原件至桌面
* Shift+Command+4 然后Esc  退出截屏
* Shift+Command+Control+3  截取全屏幕至剪贴板
* Shift+Command+Control+4  截取部分屏幕至剪贴板
* Shift+Command+Control+4+空格 截取窗口或原件至剪贴板
* Shift+Command+4 拉出选框 然后 空格 移动选框
* Shift+Command+4 然后 Shift  保持选框高度（宽度），修改宽度（高度）
* Shift+Command+4 然后 Option  保持选框中心，修改半径

##### Screencapture Shell 命令

	screencapture -h

使用`-h`参数，能够获得帮助说明，顾不对其他使用方法进行赘述。

这里主要使用`-i`进行区域截图。


例如：

	screencapture -i "/你的截图保存位置";

执行这条命令，将会激活截图。此时：

* 按下Control键，表示截图将会输出至剪贴板
* 按下Space键，表示进行窗口截图，再次按下则返回区域截图
* 按下Espace，表示取消本次截图


#### 使用 Alfred 定制工作流

Alfred是MAC下一款优秀的快速启动工具，使用它能够配置工作流，方便使用简单的命令或者快捷键实现一系列复杂的操作。

##### 添加新的工作流

打开Alfred的`Preferences`，在`Workflows`中添加新的`Empty Workflow`

![image](/images/blog/2014/02/140222132445.png)


##### 添加触发事件

这里选择快捷触发。

点击添加按钮，选择 Trigger -> Hotkey， 你可以选择你喜欢的方式来触发截图

如下图：

![image](/images/blog/2014/02/140222132722.png)



##### 添加操作脚本

点击添加按钮，选择 Actions -> Runscript

在Script中添加以下代码：

	# 参数配置
	year=$(date +%Y);
	month=$(date +%m);
	image_name="$(date +%y%m%d%H%M%S).png";
	octopress_path="/Users/zwein/Blog/zwein27.github.io";
	imagePath="${octopress_path}/source/images/blog/${year}/${month}/";
	
	# 根据年月放置文件夹
	if [ ! -d "${imagePath}" ]
	then
		mkdir -p "${imagePath}"; 
	fi
	
	# 截图
	# 参数可以输入-h查看
	screencapture -iS "${imagePath}${image_name}";
	
	# 使用系统自带的“预览”程序，进行图片的注释
	# 打开“预览”程序，也可以通过使用screencapture的 P 参数。
	open -a /Applications/Preview.app "${imagePath}${image_name}";
	
	# 输出图片在Blog中的位置到剪贴板
	echo "/images/blog/${year}/${month}/${image_name}" | pbcopy;


这样就完成了截图的配置。

输入设置的快捷键，	可以进行截图，通过按下Space切换截图形式，按下Escape选择是否取消当前截图。

截完的图片的保存位置可以再Script脚本中配置，截图完成后打开Preview进行预览和简单的配置。


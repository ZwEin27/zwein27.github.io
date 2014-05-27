---
layout: post
url: /Technology/2014/02/04/octopress-beautification/index.html
title: "Octopress 主题美化"
date: 2014-02-04 16:05:34 +0800
permalink: /Technology/2014/02/04/octopress-beautification/
comments: true
category: Technology
tags: 
- Octopress
keyworkds: [ octopress, 美化, 定制, Theme, Jekyll ] 
description: 记录Octopress美化的一些内容
lang: zh
indexer: true
disqus-url: /_posts/2014/02/04/octopress-beautification.markdown
---

关于Octopress Theme自定义的一些内容

## 定制 Octopress Theme 
Octopress本身就有很多第三方的[Theme](https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes), 试用了一些，感觉都挺不错的。最后选用了[Octoplate](https://github.com/mjhea0/octoplate), 这款主题是基于 Twitter Bootstrap 3 定制的，支持的Theme更多，也感觉更容易自定义。

添加 `Octoplate` 的方式也很简单：
<pre>
$ cd octopress
$ git clone git://github.com/mjhea0/octoplate.git .themes/octoplate
$ rake install['octoplate']
$ rake generate && rake preview
$ rake deploy
</pre>

新添加的Theme被放到octopress根目录下的`.theme`文件夹，执行`rake install`,能够将主题包中的内容加载到octopress根目录下，并提换已有文件。
<!-- more -->
注：Octoplate主题包中本身缺少一些文件，因而最好在原有Theme为classic的前提下进行添加该Theme的操作。

由于采用基于 [Twitter Bootstrap 3](http://getbootstrap.com/) 定制的框架，因而采取了其官方推荐的主题修改方式。即在不改变原有样式的基础上，添加一个CSS文件，所有的修改都在这个文件中，方便将来的升级。



## 添加页面加载进度条
在想要添加进度条的地方加入如下代码

	<div id="topbarloading"></div>

jQuery代码


	$(document).ready(function () {
	 jQuery("#topbarloading").animate({
	        width: "100%"
	    },
	    {
	        queue: false,
	        duration: 5000
	    });
	})

CSS代码
	/* Loading Bar */
	#topbarloading {
	  background-color: #F1F1F1;
	  background-image: url(https://zlz.im/wp-content/themes/dot-b/images/all.png);
	  background-position: 0px -632px;
	  color: #333;
	  display: block;
	  font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
	  font-size: 0px;
	  height: 4px;
	  line-height: 18px;
	  width: 20%;
	}

参考: [liufeiyu的博客](http://liufeiyu.cn/)  [自力博客](http://hzlzh.io/)


## 添加jQuery时间轴

### jQuery时间轴插件 Timeglider

[Timeglider](https://timeglider.com) 是一款jQuery时间轴插件，分为Student，Basic，Group 三个版本，其中Student版为免费版本。

Student版的Timeglider支持一个用户，最大允许3条时间线，并且支持嵌套，刚好可以放在Blog中使用。

使用一个邮箱并且填好一些简单的信息就可以完成注册。

### 在blog中添加Timeglider

在Blog中添加Timeglider很容易。注册完成之后，会进入编辑时间轴界面，可以在该界面进行添加时间轴灯操作。

通过顶部的Sharing菜单，可以获得选择想要公开的时间线的嵌套代码。

在Blog的相关位置贴上该代码即可。



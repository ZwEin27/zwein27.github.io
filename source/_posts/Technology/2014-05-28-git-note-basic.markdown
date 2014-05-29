---
layout: post
url: /Technology/2014/05/28/git-note-basic/index.html
title: "Pro Git 学习笔记 基础篇 "
date: 2014-05-28 09:49:44 +0800
permalink: /Technology/2014/05/28/git-note-basic/
comments: true
category: Technology
tags: [Note, Git]
keywords: Note, Pro Git
description: Git 版本控制系统的学习笔记
lang: zh
published: true
indexer: true
disqus-url: /_posts/2014/05/28/git-note.markdown
---

## Git 简介

### 参考书籍

* **[Pro Git](http://git-scm.com/book)**

### 关于版本控制

`版本控制系统` (Version Control System, VCS)是一个能够多次记录一个或多个文件改变的系统，帮助使用者在之后回溯到特地的版本。它具有以下优点：

* 将文件返回到之前的状态
* 将整个项目返回之前的状态
* 查看哪个用户的修改导致项目报错，或在什么时候提出了问题等
* 通常意味着你能够找回失去的文件

<!-- more -->

### 版本控制系统的类型

#### 本地版本控制系统 (Local Version Control Systems)

在以往的方式中，指手动的复制文件到另外一个目录中，或者再聪明点的方法，让该目录使用以时间标记来区分不同时间保存的文件版本。

为了解决手动复制文件带来的问题，程序员通过开发简单的数据库来记录所有文件的改变，如下图所示。

![image](/images/blog/2014/05/140528102131.png
)

**优点：**

* 本地存储操作方便
* 不需要复杂的配置

**缺点：**

* 不利于使用**不同系统**的开发者相互协作开发
* 本地存储中由于硬盘故障带来的**数据容易丢失**

#### 集中版本控制系统 (Centralized Version Control Systems)

指具有一个单一的服务器包含所有版本的文件，支持多客户端从该中心取出最新文件或者提交更新。很长时间以来，这已经成为版本控制的标准做法。

![image](/images/blog/2014/05/140528104049.png)

**优点：**

* 能够知道项目上的其他用户在做什么
* 管理员能够很好的**分配权限**
* 比本地版本控制系统**更容易管理**

**缺点：**

* **单点故障**。在服务器故障期间，任何人都不能协作开发或者保存文件。
* 服务器的**硬盘故障**，将导致未备份的数据丢失
* 将整个项目的内容保存在单一位置，会面临丢失所有数据的风险


#### 分布式版本控制系统 (Distributed Version Control Systems)

客户端并不只是检出文件最新的快照，而是整个资源库的镜像。

![image](/images/blog/2014/05/140528105624.png)


**优点：**

* 当服务器挂掉时，还可以进行本地提交，并在之后同步存储到服务器
* 每一个本地镜像都是所有数据的完整备份
* 可以指定和若干不同的远端代码仓库进行交互
* 可以在同一个项目中，分别和不同工作小组的人相互协作

**缺点：**

* (待补充...)

## Git 基础

了解什么是Git及其工作原理，对将来的使用是很有帮助的。即使接口相似，Git在存储信息的方式上和其他系统是不同的，理解这些不同将避免使用过程中带来的困惑。这些不同包括：

* **直接记录`快照`，而不是差异比较:** 其他系统只关心文件内容的改变，而Git更像是将变化的文件快照后，保存在微型的文件系统中。出于性能考虑，Git不会再次存储未改变的文件，而只是对上一次保存的快照做一个链接。
* **几乎所有操作都是`本地执行`:**由于Git在磁盘上保存有所有当前项目的历史更新，因此绝大部分操作只需要访问本地文件。能够提交本地，而SVN等工具却不支持。
* **时刻保持`数据完整性`:**Git在保存数据之前，所有数据都要进行内容的`校验和（checksum）`计算(使用**SHA–1 hash**)。Git不是使用文件名记录数据，而是通过记录在数据库中地址化的文件哈希值。
* **多操作仅`添加数据`:**常用的 Git 操作大多仅仅是把数据添加到数据库。一旦提交快照之后就完全不用担心丢失数据。
* **文件的`三种状态`:**已提交（committed），已修改（modified）和已暂存（staged）。已提交表示该文件已经被安全地保存在本地数据库中了；已修改表示修改了某个文件，但还没有提交保存；已暂存表示把已修改的文件放在下次提交时要保存的清单中。

### 获得Git仓库

主要有两种方式：**使用已存在仓库** 和 **从另一个服务器克隆仓库**

#### 使用已存在仓库

使用Git命令

	$ git init

该命令完成以下内容：

* 在当前目录**创建子目录(.git）**,该目录记录所有Git仓库结构必要的文件
* 使用该命令后，你的项目中的**所有文件并未被追踪**


#### 克隆仓库

使用命令

	$ git clone

需要注意，与奇特VCS不同，clone不同于checkout。

* clone:保存服务器中有的所有数据，即使未联网，也能够完成之前版本的回滚
* checkout:只获取当前版本数据，查看历史版本信息需要联网

Clone命令的使用举例：

	# 克隆一个远程服务器仓库
	$ git clone git://github.com/schacon/grit.git
	# 克隆的仓库将保存在mygrit文件夹中 - 相当于为克隆仓库取别名
	$ git clone git://github.com/schacon/grit.git mygrit

支持的传输协议包括：`git://` 、 `http(s)://` 或 `user@server:/path.git`



### 向Git仓库记录改变

每一个在你的工作空间的文件都处在**已追踪(Tracked)**或**未追踪(Untracked)**状态。

* **已追踪(Tracked):**指被纳入版本管理的文件，工作一段时间后，它的状态可能是*未更新*，*已修改*或者*已暂存*。
* **未追踪(Untracked):**所有其他文件都属于未跟踪文件，既没有上次更新时的快照，也不在当前的暂存区域。

文件的状态周期图如下所示。

![image](/images/blog/2014/05/140529082705.png)

#### 查看文件状态

查看文件状态：

	# 输入命令
	$ git status
	# 输出结果
	On branch master	#显示当前分支
	nothing to commit, working directory clean	 #当前状态信息

使用`git status`获得的状态信息包括：


* **nothing to commit, working directory clean:** 表示在当前工作环境，没有已追踪的文件是被修改的
* **Untracked files:** 查看未被追踪的文件
* **Changes to be committed:** 执行git add命令后，文件被暂存
* **Changes not staged for commit:**表示已经被追踪的文件被修改，并且还未被暂存。执行git add暂存文件后，又对该文件修改会出现该情况。此时如果commit，将会提交暂存数据，而不是已修改数据，需要执行git add重新暂存。

#### 追踪新的文件和暂存文件

追踪文件的改变可以使用`git add`命令：

	# 添加当前工作环境中名为README的未追踪文件
	$ git add README

#### 忽略文件

忽略不想追踪的文件，可以通过使用`.gitignore`文件，该文件包含以下内容：
	
	# 使用cat在命令行输出.gitignore文件中的内容
	$ cat .gitignore
	
	# .gitignore文件内容输出
	*.[oa]		#忽视所有以.o或.a为后缀结尾的文件
	*~			#忽视文本编辑软件(例如Emacs)的暂存文件
	!lib.a		#前面通过.[oa]忽略所有*.a文件，这里例外lib.a
	/TODO		#忽略根目录的TODO文件，注意不是某个子目录的TODO文件
	build/		#忽略所有build目录下的文件
	doc/*.txt	#忽略所有doc文件夹下的*.txt文件，注意不包括doc的子目录中的文件
	doc/**/*.txt	#忽略所有doc文件夹下的*.txt文件，包括所有子目录

#### 查看暂存和为暂存文件的改变内容

使用`git diff`命令可以查看文件的改变内容

	$ git diff	#比较已修改未暂存文件和已暂存文件
	
	$ git diff --cached		#比较已暂存文件和最近一次提交文件
	$ git diff --staged		#同上，相比cached更容易记忆
	
如果修改的文件已暂存，意味着`git diff`命令不会有任何输出。通过`git status`查看当前文件的状态

#### 提交改变

提交可以使用命令`git commit`。需要注意的是，commit **只提交已暂存的文件** ，所有新建或修改过却没有执行`git add`命令的都不包含在本次提交中。

因此最好先执行`git status`查看文件是否都已经被暂存，然后再执行该命令`git commit`。

	#执行该命令会打开文本编辑器以便输入本次提交的说明。
	$ git commit
	
	#使用-m参数，直接输入提交说明
	$ git commit -m "Story 182: Fix benchmarks for speed"
	#输出以下内容
	[master 463dc4f] Story 182: Fix benchmarks for speed
	 2 files changed, 3 insertions(+)
	 create mode 100644 README

每次执行提交操作，都是对项目做一次快照，以后可以回到这个这个状态，或者进行比较。

#### 跳过暂存区域

如果觉得每次提交前都需要暂存很麻烦，可以通过在提交时添加`-a
`标记，Git会在提交前自动暂存所有已追踪文件，让你跳过执行`git add`步骤。

	$ git commit -a -m 'added new benchmarks'

#### 删除文件

从Git中删除文件，需要将该文件从被追踪文件集合(更精确的说是暂存区域)中移除。

如果直接执行`rm`命令删除命令，并不能将文件从暂存空间移除。接着执行`git rm `命令，将文件从暂存空间移除。

如果删除之前修改过并且已经放到暂存区域(还没有提交)的话，则必须要用强制删除选项 `-f`（即 force 的首字母），以防误删除文件后丢失修改的内容。

如果想保持文件在磁盘中，但是又想删除该文件在暂存空间的记录。这种情况的典型例子是你不小心暂存了想要放入`.gitignore`中的文件。可以通过使用`--cached`解决。

	#从暂存空间移除readme.txt文件，但在磁盘保留该文件
	$ git rm --cached readme.txt

#### 移动文件

不像其他的 VCS 系统，Git 并不跟踪文件移动操作。如果在 Git 中重命名了某个文件，仓库中存储的元数据并不会体现出这是一次改名操作。

移动过文件使用命令`git mv`

	$ git mv file_from file_to
	
	# 举例
	$ git mv README.txt README
	$ git status
	On branch master
	Changes to be committed:
	(use "git reset HEAD <file>..." to unstage)

        renamed:    README.txt -> README
    
    # 举例中的代码相当于
    $ mv README.txt README
	$ git rm README.txt
	$ git add README


### 查看提交历史

使用`git log`命令

	$ git log

未带参数的`git log`命令，会以逆时间顺序列出项目库的提交列表。

`git log`的参数

* `-p`: 显示每次提交的内容差异
* `-<n>`: 只显示最新的n条
* `-p --word-diff`: `--word-diff`接在`-p`之后，使用文字描述差异
* `-U1`: 设置上下文只显示一行
* `--stat`: 仅显示简要的增改行数统计
* `--pretty`: 可以指定使用完全不同于默认格式的方式展示提交历史

`--pretty`的使用
 
	$ git log --pretty=oneline|short|full|fuller|format`
	

	$ git log --pretty=format:"%h - %an, %ar : %s"
	ca82a6d - Scott Chacon, 11 months ago : changed the version number
	085bb3b - Scott Chacon, 11 months ago : removed unnecessary test code
	a11bef0 - Scott Chacon, 11 months ago : first commit
	

### 撤销操作

#### 改变最近一次提交

当你的一次提交中忘记添加一些文件时，可以在`git add`补充的文件后，使用`--amend`来修改最近一次提交。

	$ git commit -m 'initial commit'	#最近一次提交
	$ git add forgotten_file			#添加要提交的文件
	$ git commit --amend				#修改最新一次提交

执行`git commit --amend`后，会合并两个commit为一个commit，使用原来的提交描述`initial commit`，并添加提交文件`forgotten_file`。

#### 撤销暂存文件

如果不小使用`git add`命令添加文件不想提交的文件到暂存空间，可以通过`git reset HEAD <file>`命令来撤销。举例：

	# 执行撤销操作之前
	$ git add .		#添加当前目录下的所有文件到暂存空间
	$ git status	#查看状态
	On branch master
	Changes to be committed:
	(use "git reset HEAD <file>..." to unstage)  #操作提示

        modified:   README.txt		#暂存的文件
        modified:   benchmarks.rb
    
    #执行撤销操作
    $ git reset HEAD benchmarks.rb		#执行撤销命令
	Unstaged changes after reset:		
	M       benchmarks.rb				#该文件的暂存被撤销
	$ git status		#查看状态
	On branch master
	Changes to be committed:
	  (use "git reset HEAD <file>..." to unstage)

        modified:   README.txt		#该文件仍在暂存空间

	Changes not staged for commit:
	  (use "git add <file>..." to update what will be committed)
	  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   benchmarks.rb	#该文件的暂存已被撤销

#### 撤销文件的修改

对与已修改未暂存的文件，可以通过`git checkout -- <file>`来撤销修改。

这是条危险的命令，所有对文件的修改都没有了，因为我们刚刚把之前版本的文件复制过来重写了此文件。

注：任何已经提交到 Git 的都可以被恢复。即便在已经删除的分支中的提交，或者用 --amend 重新改写的提交，都可以被恢复。你可能失去的数据，仅限于**没有提交过的**，对 Git 来说它们就像从未存在过一样。

### 远程仓库的使用
### 标签
### 技巧和窍门





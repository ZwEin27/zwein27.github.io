---
layout: post
url: /Technology/2014/02/06/octopress-domain-settings/index.html
title: "Octopress 域名定制"
date: 2014-02-06 19:28:35 +0800
permalink: /Technology/2014/02/06/octopress-domain-settings/
comments: true
category: Technology
tags: [ Octopress, WebDev]
keywords: octopress godaddy dnspod com github pages
description: 为 Github Pages 配置域名
lang: zh
indexer: true
disqus-url: /_posts/2014/02/06/octopress-domain-settings.markdown
---
使用Github Pages搭建博客进行的差不多了，原本就想注册一个属于自己的域名，今天特定实施了一下

## 选择域名注册服务机构

比较了挺多域名注册服务提供商，比如国内的万网，还有国外的Godaddy等等，最后选择了国外的`Godaddy`。下面对一些我觉得比较好的域名注册提供商进行比较。

<!-- more -->

### [Godaddy](http://www.godaddy.com/)
根据网络上的评论，Godaddy的规模是最大的，也经常会有一些优惠，优惠码可以通过搜索`Godaddy 优惠码`找到很多，不过现在并没有太多的价格优势。笔者选择购买的.com域名，未优惠的价格为$12.99，使用优惠码`iap899c1`优惠后的价格为$8.99，便宜的比较多。值得一提的是Godaddy支持`支付宝`付款，并且直接选择美元支付在切换到支付宝付款页面时会便宜几块钱。实际笔者购买该域名话费为55.66元，还算可以。

网络上有很多Godaddy的优惠码，很多网页也会不定期的更新，在笔者买的时候有找到$1.99的优惠码，无奈该优惠码仅支持美国籍的信用卡付款，而且一个信用卡用户仅能使用一次，因此最后没有选择这个方式，还在淘宝上花了不少时间,T.T....

这里再推荐个提供`优惠码`的的网站，方便大家找到合适的优惠码:[NameDog](http://coupons.namedog.com/)


### [Name](https://www.name.com/)
相比Godaddy，Name的优惠码没有那么多，但是有提供whois隐私保护免费的优惠码，这项服务用来保护注明注册者的隐私信息，原价有的地方$9.99，Name上是$1.99好像，使用优惠码可以免费，对于隐私保密方面有特殊要求的用户可以选择在Name购买。对于com域名，name上1年要$9.99没有，这是在不用优惠码的情况下的，相对Godaddy来说还算便宜，不过由于其还不支持支付宝付款，对于国内用户来说不是很方便。


### [万网](http://www.net.cn/)
笔者购买域名的时候万网的广告做的铺天盖地，看到也确实便宜，对比Godaddy来说是便宜的，首付49元，后期续费都是55元。要知道，Godaddy上要使用优惠码才能达到和万网续费一个水平的价格，而且貌似优惠码的优惠力度越来越小了。没有选择万网是因为万网是国内产品，想到可能会面临的备案等麻烦，还是选择了拥抱外面的世界了。




## 域名配置

### 配置Godaddy域名解析
在Godaddy上购买域名成功之后，可以到其[控制面板](https://dcc.godaddy.com/)配置域名解析。考虑到主要在国内使用，笔者选择[Dnspod](https://www.dnspod.cn)来解析域名。首先需要在Dnspod上注册一个账号，然后新建一个域名，并正确配置A记录和CNAME记录，记录成功后可以根据官方提供的[教程](https://support.dnspod.cn/Kb/showarticle/tsid/42/)修改Godaddy的NameServers。


### 配置Github Pages
在Octopress根目录的source文件夹下新建CNAME文件，并在里面输入想要绑定的域名。比如顶级域名 example.com 或者二级域名 xxx.example.com.
由于DNS解析改成使用Dnspod, 所以可以在Dnspod上配置CNAME信息。

如笔者在Dnspod上添加记录为：主机记录(@)，记录类型(CNAME)，记录值(xxxx.github.io)。

并且在CNAME中填写lzteng.com
这样使用lzteng.com，便可以自动解析到笔者的Github Pages

注意：配置DNS可能需要72小时以内的时间，需要耐心等待，笔者设置完成后还没1个小时便可以访问了。
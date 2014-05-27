---
layout: post
url: /Development/2014/02/20/ios-note-6-location-and-map/index.html
title: "iOS 开发笔记 6 - 定位和地图"
date: 2014-02-20 09:36:54 +0800
permalink: /Development/2014/02/20/ios-note-6-location-and-map/
comments: true
category: Development
tags: iOS
keywords: iOS Location Map
description: iOS开发中有关定位和地图的相关内容
lang: zh
indexer: true 
---

## Core Location

IOS中的core location提供了定位功能，能定位装置的当前坐标，同时能得到装置移动信息。

因为对定位装置的轮询是很耗电的，所以最好只在非常必要的前提下启动。

其中，最重要的类是CLLocationManager，定位管理。

http://blog.csdn.net/csj1987/article/details/6657468

其定位有3种方式：
1，GPS，最精确的定位方式，貌似iphone1是不支持的。
2，蜂窝基站三角定位，这种定位在信号基站比较秘籍的城市比较准确。
3，Wifi，这种方式貌似是通过网络运营商的数据库得到的数据，在3种定位种最不精确
<!-- more -->

IOS SDK提供的Core Location能比较好的提供获取位置信息的功能，获取位置信息涉及如下几个类：

### CLLocationManager（位置管理器）
### CLLocation, CLLocationManagerdelegate（协议、提供委托方法）

### CLLocationCoodinate2D（存储坐标位置）


#### CLLocationManager的属性

##### desiredAccuracy:位置的精度属性

    
取值有如下几种：

* **kCLLocationAccuracyBest**: 
精确度最佳

* **kCLLocationAccuracynearestTenMeters**: 
精确度10m以内

* **kCLLocationAccuracyHundredMeters**: 
精确度100m以内

* **kCLLocationAccuracyKilometer**: 
精确度1000m以内

* **kCLLocationAccuracyThreeKilometers**: 
精确度3000m以内

##### distanceFilter：横向移动多少距离后更新位置信息
##### delegate：响应CLLocationManagerdelegate的对象


### 使用Core Location进行定位

1，引入CoreLocation的包，一般的默认模板里是没有的，所以需要手动导入。

2，通过启动CLLocationManager来启动定位服务，因为定位信息是需要轮询的，而且对于程序来说是需要一定时间才会得到的，所以lcationManager的操作大多都给委托来完成。

加载locationManager的代码：

    CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
    locationManager.delegate=self;
     
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0f;
    //启动位置更新
    [locationManager startUpdatingLocation];

desiredAccuracy，设置定位的精度，可以设为最优，装置会自动用最精确的方式去定位。

distanceFilter，距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序，它的单位是米，这里设置为至少移动1000再通知委托处理更新。

startUpdatingLocation，启动定位管理，一般来说，在不需要更新定位时最好关闭它，用stopUpdatingLocation，可以节省电量。

### 委托CLLocationManagerDelegate

对于委托CLLocationManagerDelegate，最常用的方法是：

	- (void)locationManager:(CLLocationManager *)manager   
	    didUpdateToLocation:(CLLocation *)newLocation   
		fromLocation:(CLLocation *)oldLocation;
 	          
这个方法即定位改变时委托会执行的方法。

可以得到新位置，旧位置，CLLocation里面有经度纬度的坐标值，

同时CLLocation还有个属性horizontalAccuracy，用来得到水平上的精确度，它的大小就是定位精度的半径，单位为米。
如果值为－1，则说明此定位不可信。

另外委托还有一个常用方法是

	- (void)locationManager:(CLLocationManager *)manager   
	       didFailWithError:(NSError *)error ;
       
当定位出现错误时就会调用这个方法。



### 地理位置反向编码

Core Location 中得到的定位信息都是以经度和纬度等表示的地理信息

很多时候我们需要把它反向编码成普通人能读懂的地理位置描述如：X国XX市XXX区XXX街道XX号，这就需要用到MapKit中的一个地理位置反向编码工具：MKReverseGeocoder，

#### 实现方法

##### 实现协议MKReverseGeocoderDelegate

首先要实现协议MKReverseGeocoderDelegate，因为将坐标信息发到服务器再反回来需要一定的时间，所以为了防止阻塞，发出信息后并不知到什么时候会返回信息，信息返回时会通知委托方法。

这里实现这个类主要时为了实现2个方法如下：

	- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	    NSLog(@"MKReverseGeocoder has failed.");
	}
	- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	    
	    NSLog(@"当前地理信息为：%@",placemark);
	}

didFailWithError这个方法是来处理返回错误信息的

didFindPlacemark则是地理信息返回值，地理信息包含在placemark里面，此对象中包含国家，城市，区块，街道等成员变量。

##### 反向编码器

然后可以init一个反向编码器，然后发出请求了：

	MKReverseGeocoder *reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
	    NSLog(@"%g",coordinate.latitude);
	    NSLog(@"%g",coordinate.longitude);
	    reverseGeocoder.delegate = self;
	    [reverseGeocoder start];

MKReverseGeocoder除了start方法，还有cancel方法来取消请求。


## 地图展示

### 使用MKMapView展示地图

MKMapView提供了一套可植入的地图接口，可以让我们在应用中展示地图，并对其进行相关的操作。

一般来说，我们可以指定一个展示区域，放一些标记在上面，还可以加盖一些层在上面。

MKMapView依赖Google map里面相关服务（如Google Earth API等），所以地图的左下角会有Google字样。

#### 实现方法

waiting for more...



> 参考
>
> [关于Core Location－ios定位](http://blog.csdn.net/csj1987/article/details/6657468)
> [Ryan's zone](http://blog.csdn.net/ryantang03/article/details/7798580)





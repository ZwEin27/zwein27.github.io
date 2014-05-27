---
layout: post
url: /Diary/2014/02/27/parse-note/index.html
title: "Parse Note"
date: 2014-02-27 19:40:39 +0800
permalink: /Diary/2014/02/27/parse-note/
comments: true
category: Technology
tags: [BaaS, Parse]
keywords: Parse Baas
description: Parse Note
lang: zh
indexer: true
disqus-url: /_posts/2014/02/27/parse-note.markdown
---

## Parse在IOS下的环境配置

[官方教程](https://parse.com/apps/quickstart#parse_push/ios/existing)

运行后可能会遇到下面的问题：

     Undefined symbols for architecture armv7:
	 "_FBTokenInformationTokenKey", referenced from:
	 -[PFFacebookTokenCachingStrategy accessToken] in Parse(PFFacebookTokenCachingStrategy.o)
	 -[PFFacebookTokenCachingStrategy setAccessToken:] in Parse(PFFacebookTokenCachingStrategy.o)
	 "_FBTokenInformationExpirationDateKey", referenced from:
	 -[PFFacebookTokenCachingStrategy cacheTokenInformation:] in     Parse(PFFacebookTokenCachingStrategy.o)
	 -[PFFacebookTokenCachingStrategy expirationDate] in Parse(PFFacebookTokenCachingStrategy.o)
	 -[PFFacebookTokenCachingStrategy setExpirationDate:] in Parse(PFFacebookTokenCachingStrategy.o)
	 "_OBJC_METACLASS_$_FBSessionTokenCachingStrategy", referenced from:
	 _OBJC_METACLASS_$_PFFacebookTokenCachingStrategy in Parse(PFFacebookTokenCachingStrategy.o)
	 "_OBJC_CLASS_$_FBSessionTokenCachingStrategy", referenced from:
	 _OBJC_CLASS_$_PFFacebookTokenCachingStrategy in Parse(PFFacebookTokenCachingStrategy.o)
	 "_FBTokenInformationUserFBIDKey", referenced from:
	 -[PFFacebookTokenCachingStrategy facebookId] in Parse(PFFacebookTokenCachingStrategy.o)
	 -[PFFacebookTokenCachingStrategy setFacebookId:] in Parse(PFFacebookTokenCachingStrategy.o)
	 "_OBJC_CLASS_$_FBRequest", referenced from:
	 objc-class-ref in Parse(PFFacebookAuthenticationProvider.o)
	 "_OBJC_CLASS_$_FBSession", referenced from:
	 objc-class-ref in Parse(PFFacebookAuthenticationProvider.o)
	 ld: symbol(s) not found for architecture armv7
	 clang: error: linker command failed with exit code 1 (use -v to see invocation)





解决方法：
新建一个名为FBMissingSymbols的Obj-C文件，删除掉.h文件，因为并不需要使用到。
在.m文件中添加以下内容即可<!-- more -->

	NSString *FBTokenInformationExpirationDateKey = @"";
	NSString *FBTokenInformationTokenKey = @"";
	NSString *FBTokenInformationUserFBIDKey = @"";
	@interface FBAppCall:NSObject
	@end
	@implementation FBAppCall
	@end
	@interface FBRequest:NSObject
	@end
	@implementation FBRequest
	@end
	@interface FBSession:NSObject
	@end
	@implementation FBSession
	@end
	@interface FBSessionTokenCaching:NSObject
	@end
	@implementation FBSessionTokenCaching
	@end
	@interface FBSessionTokenCachingStrategy:NSObject
	@end
	@implementation FBSessionTokenCachingStrategy
	@end
	
参考自：[stackoverflow.com](http://stackoverflow.com/questions/15457136/parse-for-ios-errors-when-trying-to-run-the-app)






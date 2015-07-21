/************************************************************
 Copyright (C), 1989-2015, Nanhu Tech. co.,Ltd.
 FileName: NHURLCache.h
 Author:Hu Jiaju      Version :1.0     Date:20/07/2015
 Description:This file implements the HTML file of the offline cache, reading function
 History:
 <author>  <time>   <version >   <desc>
 Jiaju    15/07/20     1.0     build this moudle
 ***********************************************************/

#import <Foundation/Foundation.h>

@interface URLCacheLib : NSURLCache

/**
 @Discussion:
 @param:memoryCapacity capacity in memory
 @param:diskCapacity capacity on disk
 @param:path disk path for cache
 @param:cacheTime
 */
- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime;

@end

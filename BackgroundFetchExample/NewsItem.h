//
//  NewsItem.h
//  BackgroundFetchExample
//
//  Created by Manju Sj on 5/16/16.
//  Copyright (c) 2016 Manju Sj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *text;
@end

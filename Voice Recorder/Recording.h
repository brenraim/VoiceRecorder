//
//  Recording.h
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recording : NSObject <NSCoding>
@property (strong, nonatomic) NSString* dateString;
@property (strong, nonatomic) NSDate* date;
// Always save in ~/Documents/yyyyMMddHHmmss
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSString* path; // readonly ==> There is no setter (?)
//@property (readonly, nonatomic) NSURL* url; // readonly ==> There is no setter (?)
@property (strong, nonatomic) NSURL* url; // readonly ==> There is no setter (?)
-(Recording*) initWithDate:(NSDate*) aDate;
@end
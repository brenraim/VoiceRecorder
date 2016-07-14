//
//  Recording.m
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "Recording.h"

static Recording* initialRecording;

@implementation Recording
@synthesize dateString;
@synthesize date;
@synthesize description;
@synthesize path;
@synthesize url;
-(Recording*) initWithDate:(NSDate*) aDate {
    if (initialRecording == nil) {
        initialRecording = [[Recording alloc] init];
        initialRecording.date = aDate;
    }
    
    return initialRecording;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.url = [decoder decodeObjectOfClass: [Recording class] forKey: @"url"];
        self.dateString = [decoder decodeObjectOfClass: [Recording class] forKey: @"dateString"];
        self.date = [decoder decodeObjectOfClass: [Recording class] forKey: @"date"];
        self.path = [decoder decodeObjectOfClass: [Recording class] forKey: @"path"];
        self.description = [decoder decodeObjectOfClass: [Recording class] forKey: @"description"];
    }
    return self;
}

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".caf"];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: self.url forKey: @"url"];
    [encoder encodeObject: self.dateString forKey: @"dateString"];
    [encoder encodeObject: self.date forKey: @"date"];
    [encoder encodeObject: self.path forKey: @"path"];
    [encoder encodeObject: self.description forKey: @"description"];
}

-(NSString*) description {
    //NSLog(@"PLEASE");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    //NSLog(@"The description is %@",[formatter stringFromDate:self.date]);
    NSString* dateStringVar = [formatter stringFromDate:self.date];
    return [NSString stringWithFormat:@"%@", dateStringVar];
}

-(NSString*) path {
    //NSString* home = NSHomeDirectory();
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateStringVar = [formatter stringFromDate:self.date];
    //NSLog(@"dateString: %@", dateString);
    return [NSString stringWithFormat:@"/Users/Luca/Desktop/Universal/RecordingsThree/%@.caf", dateStringVar]; // .caf ==> Core Audio File
}

-(NSURL*) url{
    //NSURL *baseURL = [NSURL fileURLWithString:@"%@", path];
    //NSURL *URL = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
    NSString* home = NSHomeDirectory();
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateStringVar = [formatter stringFromDate:self.date];
    // NSLog(@"dateString: %@", dateString);
    NSString* pathForURL = [NSString stringWithFormat:@"/Users/Luca/Desktop/Universal/RecordingsThree/%@.caf", dateStringVar]; // .caf ==> Core Audio File
    //NSLog(@"url working?");
    //NSLog(@"%@", pathForURL);
    //NSURL *URL = [[NSURL alloc] initWithString:pathForURL];
    //NSLog(@"url working?");
    //NSString* filePath = [URL path];
    //NSLog(@"the url: %@", URL);
    //NSLog(@"the path: %@", filePath);
    //return [URL absoluteURL];
    return [NSURL fileURLWithPath:pathForURL];
}
@end
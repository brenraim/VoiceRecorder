//
//  TableViewController.h
//  Voice Recorder
//
//  Created by Luca on 7/8/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Recording.h"

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate>

@property (strong, nonatomic) NSMutableArray* listOfPresidents;
@property (strong, nonatomic) NSMutableArray* scientists;
@property (strong, nonatomic) NSMutableArray* recordings;
@property (strong, nonatomic) AVAudioPlayer* player;

@end
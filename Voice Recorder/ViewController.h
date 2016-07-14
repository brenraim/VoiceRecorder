//
//  ViewController.h
//  Voice Recorder
//
//  Created by Brendan on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recording.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
@property (nonatomic, strong) NSTimer *myTimer;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic, strong) IBOutlet UIProgressView *progressBar;
@property (strong) Recording* currentRecording;
@property (strong, nonatomic) NSMutableArray* listOfRecordings;

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer* player;

@property (strong, nonatomic) NSMutableArray* otherListOfPresidents;

@property (assign, nonatomic) BOOL recordingBool;

- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;

@end
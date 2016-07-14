//
//  ViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Recording.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// Recorder class code:
/*
 @interface Recordign NSObject <NSSecureCoding> // ???
 @property (strong, nonatomic) NSDate* date;
 // always save in ~/Documents/yyyyMMddHHmmss
 @property (readonly, nonatomic) NSString* path; // readonly ==> There is no setter (?)
 @property (readonly, nonatomic) NSURL* url; // readonly ==> There is no setter (?)
 -(Recording*) initWithDate:(NSDate*) aDate;
 @end
 
 @implementation Recording
 @synthesize date;
 -(Recording*) iniWithDate:(NSDate*) aDate {
 self = [super init];
 if (self) {
 self.date = aDate;
 }
 return self;
 }
 
 -(NSString*) path {
 NSString* home = NSHomeDirectory();
 NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
 [formatter setDateFormat:@"yyyyMMddHHmmss"];
 NSString* dateString = [formatter stringFromDate:self.date];
 return [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString]; // .caf ==> Core Audio File
 }
 
 -(NSURL*) url:(NSString*) path {
 //NSURL *baseURL = [NSURL fileURLWithString:@"%@", path];
 //NSURL *URL = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
 NSURL *URL = [NSURL initWithString:@"%@", path];
 return [URL absoluteURL];
 }
 @end
 
 Recording* r = [[Recording alloc] iniWithDate [NSDate today]];
 
 
 
 
 
 
 1. Make a Recording Object
 2. Set currentRecodring to new Recording
 3. Insert currentRecording into recordingList
 4. Set up recording session
 5. Set up timer to update ProgressView & expire the Recording session (?)
 
 StopButton Pressed
 1. Turn off the timer for ProgressView
 2. Clearn up Recording Session
 3. Set currentRecodring to nil
 4. Reset ProgressView
 
 didFinish // when timer finishes
 1. Turn off timer for ProgressView
 2. Clean up session
 3. Set currentRecording to nil
 4. Reset ProgressView
 */

@synthesize otherListOfPresidents;
@synthesize listOfRecordings;
@synthesize recorder;
@synthesize currentRecording;
@synthesize player;
@synthesize recordingBool;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    //self.startButton.center = self.view.center;
    //self.stopButton.center = self.view.center;
    self.progressBar.center = self.view.center;
    [self.view addSubview:self.progressBar];
    listOfRecordings = [[NSMutableArray alloc]init];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count = 0; count++;
    
    if (count <= 100000000) { // 100000000 works
        self.progressBar.progress = (float)count/100000.0f; // 100000.0f works
    } else {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
}

- (void) stopTimer
{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//listOfRecordings = [[NSMutableArray alloc]init];

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".caf"];
}

- (IBAction)startButton:(id)sender {
    if (recordingBool == NO) {
        recordingBool = YES;
    NSString* archive = [NSString stringWithFormat:@"/Users/monicaraimann/Desktop/Data/RecordingList"];
    if([[NSFileManager defaultManager] fileExistsAtPath: archive]){
        self.listOfRecordings = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
        [[NSFileManager defaultManager] removeItemAtPath:archive error:nil];
    }else{
        // Doesn't exist!
        NSLog(@"No file to open!!");
        //exit(1);
    }
    
    NSLog(@"self.listOfRecordings: %@", self.listOfRecordings);
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    NSError* err = nil;
    [audioSession setCategory: AVAudioSessionCategoryRecord error: &err];
    if(err){
        NSLog(@"audioSession: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        return;
    }
    err = nil;
    [audioSession setActive:YES error:&err];
    if(err){
        NSLog(@"audioSession: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    NSMutableDictionary* recordingSettings = [[NSMutableDictionary alloc] init];
    
    [recordingSettings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    
    [recordingSettings setValue:@44100.0 forKey:AVSampleRateKey];
    
    [recordingSettings setValue:@1 forKey:AVNumberOfChannelsKey];
    
    [recordingSettings setValue:@16 forKey:AVLinearPCMBitDepthKey];
    
    [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsBigEndianKey];
    
    [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsFloatKey];
    
    [recordingSettings setValue:@(AVAudioQualityHigh)
                         forKey:AVEncoderAudioQualityKey];
    
    
    NSDate* now = [NSDate date];
    
    self.currentRecording = [[Recording alloc] initWithDate: now];
    [self.listOfRecordings addObject: self.currentRecording];
    
    NSLog(@"%@",self.currentRecording);
    
    err = nil;
    
    self.recorder = [[AVAudioRecorder alloc]
                     initWithURL:self.currentRecording.url
                     settings:recordingSettings
                     error:&err];
    
    if(!self.recorder){
        NSLog(@"recorder: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Warning"
                                    message:[err localizedDescription]
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    //prepare to record
    [self.recorder setDelegate:self];
    [self.recorder prepareToRecord];
    self.recorder.meteringEnabled = YES;
    
    BOOL audioHWAvailable = audioSession.inputAvailable;
    if( !audioHWAvailable ){
        UIAlertController* cantRecordAlert = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:@"Audio input hardware not available."
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [cantRecordAlert addAction:defaultAction];
        [self presentViewController:cantRecordAlert animated:YES completion:nil];
        
        
        return;
    }
    
    // start recording
    [recorder recordForDuration:(NSTimeInterval)5];
    
    self.progressBar.progress = 0.0;
    self.myTimer = [NSTimer
                  scheduledTimerWithTimeInterval:0.2
                  target:self
                    selector:@selector(updateUI:)
                  userInfo:nil
                  repeats:YES];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"hello from the other side: %@", recordings[0]);
    TableViewController* pvc = (TableViewController*) segue.destinationViewController;
    pvc.recordings = self.listOfRecordings;
    //NSLog(@"hello from the other side: %@", recordings[0]);
}

- (IBAction)stopButton:(id)sender {
    [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    
    NSString* archive = [NSString stringWithFormat:@"/Users/monicaraimann/Desktop/Data"];
    [NSKeyedArchiver archiveRootObject: self.listOfRecordings toFile: archive];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: archive]);
    
    NSLog(@"Playing %@", self.currentRecording.description);
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath: self.currentRecording.path], @"Doesn't exist");
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: self.currentRecording.url error:&error];
    if(error){
        NSLog(@"playing audio: %@ %ld %@", [error domain], [error code], [[error userInfo] description]);
        return;
    }else{
        player.delegate = self;
    }
    if([player prepareToPlay] == NO){
        NSLog(@"Not prepared to play!");
        return;
    }
    NSLog(@"CMON");
    [player play];
    NSLog(@"YES");
    
    self.recordingBool = NO;
}

@end






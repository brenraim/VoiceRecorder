//
//  TableViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/8/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Recording.h"

@interface TableViewController ()

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation TableViewController

@synthesize listOfPresidents;
@synthesize scientists;
@synthesize recordings;
@synthesize player;

/*
 -(TableViewController*) initWithCoder:(NSCoder *) aDecoder {
 self = [super initWithCoder: aDecoder];
 if(self) {
 self.listOfPresidents = [[NSMutableArray alloc] init];
 [self.listOfPresidents addObject:@"Washington"];
 [self.listOfPresidents addObject:@"Licoln"];
 [self.listOfPresidents addObject:@"LBJ"];
 }
 
 return self;
 }
 */

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.scientists = [[NSMutableArray alloc] init];
        [self.scientists addObject: @"R. Franklin"];
        [self.scientists addObject: @"A. Turing"];
        [self.scientists addObject: @"I. Newton"];
        [self.scientists addObject: @"L. Da Vinci"];
        [self.scientists addObject: @"M. Curie"];
        [self.scientists addObject: @"N. Tesla"];
        [self.scientists addObject: @"S. Hawking"];
        [self.scientists addObject: @"R. Feynmam"];
        [self.scientists addObject: @"A. Einstein"];
        [self.scientists addObject: @"B. Franklin"];
        [self.scientists addObject: @"G. Washington Carver"];
        [self.scientists addObject: @"Euclid"];
        [self.scientists addObject: @"N. Tyson"];
        [self.scientists addObject: @"B. Greene"];
        [self.scientists addObject: @"J. Nash"];
        [self.scientists addObject: @"C. Darwin"];
        [self.scientists addObject: @"Galileo"];
        [self.scientists addObject: @"N. Copernicus"];
        [self.scientists addObject: @"G. Hopper"];
        [self.scientists addObject: @"A. Lovelace"];
        [self.scientists addObject: @"T. Morse"];
        [self.scientists addObject: @"J. Thompson"];
        [self.scientists addObject: @"E. Rutherford"];
    }
    
    return self;
}

/*
 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 //NSLog(@"hello from the other side: %@", recordings[0]);
 ViewController* pvc = (ViewController*) segue.destinationViewController;
 pvc.otherListOfPresidents = self.listOfPresidents;
 recordings = [[NSMutableArray alloc]init];
 pvc.listOfRecordings = self.recordings;
 //NSLog(@"hello from the other side: %@", recordings[0]);
 }
 */

- (void) viewWillDisappear:(BOOL)animated {
    NSLog(@"Archive my list of recordings to a file!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    NSError* err = nil;
    [audioSession setCategory: AVAudioSessionCategoryPlayback error: &err];
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //NSLog(@"hello from the other side: %@", recordings[0]);
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recordings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    NSString* path = [NSString stringWithFormat:@"/Users/monicaraimann/Desktop/Data"];
    
    Recording* r = [recordings objectAtIndex:indexPath.row];
    
    NSString *selectedSound = [path stringByAppendingPathComponent:r.description];
    
    cell.textLabel.text = r.description;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Play the audio file that maps onto the cell
    // Recording* r = [self.recordingsList objectAtIndex: indexPath.row];
    // [self play: r];
    
    NSString* path = [NSString stringWithFormat:@"/Users/monicaraimann/Desktop/Data"];
    
    Recording* r = [recordings objectAtIndex:indexPath.row];
    
    NSString *selectedSound = [path stringByAppendingPathComponent:r.description];
    NSString* realSound = [selectedSound stringByAppendingString:@".caf"];
    /*
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath: realSound], @"Doesn't exist");
    NSError *error;
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:realSound] error:&error];
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
    [player play];
    
    NSURL *url =[NSURL fileURLWithPath:realSound];
    NSLog(@"selectedSound: %@", realSound);
     */
    ///*
    NSLog(@"Playing %@", r.description);
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath: r.path], @"Doesn't exist");
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: r.url error:&error];
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
    NSLog(@"CMON TABLE");
    [player play];
    NSLog(@"YES TABLE");
    // */
    
    /*
     NSString *soundPath = [[NSBundle mainBundle] pathForResource:selectedSound ofType:@"caf"];
     NSLog(@"soundPath:  %@", soundPath);
     SystemSoundID soundID;
     AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &soundID);
     AudioServicesPlaySystemSound(soundID);
     */
    
    //AVAudioPlayer *player;
    //player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    //player.delegate = self;
    
    // Change audio session for playback
    /*
     if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil])
     {
     NSLog(@"Error updating audio session: %@", error.localizedFailureReason);
     return;
     }
     */
    
    //self.title = @"Playing back recording...";
    
    //[player prepareToPlay];
    //[player play];
    
    /*
     NSString *soundFilePath = [NSString stringWithFormat:@"%@/test.m4a",
     [[NSBundle mainBundle] resourcePath]];
     NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
     
     AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
     error:nil];
     player.numberOfLoops = -1; //Infinite
     
     [player play];
     */
    //}
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
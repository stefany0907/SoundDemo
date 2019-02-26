//
//  ViewController.m
//  SoundDemo
//
//  Created by Matt Chen on 2/23/19.
//  Copyright © 2019 Matt Chen. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
@import AVFoundation;

@interface ViewController ()
@property (assign, nonatomic) SystemSoundID beepA;
@property (assign, nonatomic) SystemSoundID drum;
@property (assign, nonatomic) SystemSoundID socal;
@property (assign, nonatomic) SystemSoundID guitar;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (assign, nonatomic) BOOL beepAGood;
@property (assign, nonatomic) BOOL drumGood;
@property (assign, nonatomic) BOOL songGood;
@property (assign, nonatomic) BOOL socalGood;
@property (assign, nonatomic) BOOL guitarGood;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *soundAPath = [[NSBundle mainBundle] pathForResource:@"sampleA" ofType:@"aif"];
    NSURL *urlA = [NSURL fileURLWithPath:soundAPath];
    
    NSString *soundBPath = [[NSBundle mainBundle] pathForResource:@"Drum" ofType:@"aif"];
    NSURL *urlB = [NSURL fileURLWithPath:soundBPath];
    
    NSString *songPath = [[NSBundle mainBundle] pathForResource:@"AntonModernHipHop" ofType:@"mp3"];
    NSURL *urlC = [NSURL fileURLWithPath:songPath];
    
    NSString *soundDPath = [[NSBundle mainBundle] pathForResource:@"SoCal" ofType:@"aif"];
    NSURL *urlD = [NSURL fileURLWithPath:soundDPath];
    
    NSString *soundEPath = [[NSBundle mainBundle] pathForResource:@"Guitar" ofType:@"aif"];
    NSURL *urlE = [NSURL fileURLWithPath:soundEPath];
     
    // Archaic c code
    // __bridge c-level cast
    // load the sounds
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlA, &_beepA);
    if (statusReport == kAudioServicesNoError) {
        self.beepAGood = YES;
    } else {
        self.beepAGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepA" message:@"beepA problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlB, &_drum);
    if (statusReport == kAudioServicesNoError) {
        self.drumGood = YES;
    } else {
        self.drumGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepB" message:@"beepB problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlD, &_socal);
    if (statusReport == kAudioServicesNoError) {
        self.socalGood = YES;
    } else {
        self.socalGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load socal" message:@"socal problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlE, &_guitar);
    if (statusReport == kAudioServicesNoError) {
        self.guitarGood = YES;
    } else {
        self.guitarGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load guitar" message:@"guitar problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    NSError *err;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlC error:&err];
//    NSLog(@"self.player %@", self.player);
    if (!self.player) {
        self.songGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load mp3" message:[err localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        self.songGood = YES;
    }
}

- (IBAction)playPiano:(id)sender {
    NSLog(@"beepA tapped");
//  NSLog(@"beepA Good: %d", self.beepAGood);
    if (self.beepAGood) {
//        NSLog(@"play piano");
        AudioServicesPlaySystemSound(self.beepA);
    }
}


- (IBAction)playDrum:(id)sender {
    NSLog(@"Drum tapped");
    if (self.drumGood) {
        AudioServicesPlaySystemSound(self.drum);
    }
}
- (IBAction)playSocal:(id)sender {
    if (self.socalGood) {
        AudioServicesPlaySystemSound(self.socal);
    }
}

- (IBAction)playGuitar:(id)sender {
    if (self.guitarGood) {
        AudioServicesPlaySystemSound(self.guitar);
    }
}



- (IBAction)playMedia:(id)sender {
    NSLog(@"song good, %d", self.songGood);
    if (self.songGood) {
        [self.player play];
    }
}
- (IBAction)stopMedia:(id)sender {
    if (self.songGood) {
        [self.player stop];
    }
}

- (void) dealloc {
    if (self.beepAGood) {
        AudioServicesDisposeSystemSoundID(self.beepA);
    }
    if (self.drumGood) {
        AudioServicesDisposeSystemSoundID(self.drum);
    }
    if (self.socalGood) {
        AudioServicesDisposeSystemSoundID(self.socal);
    }
    if (self.guitarGood) {
        AudioServicesDisposeSystemSoundID(self.guitar);
    }
}

@end

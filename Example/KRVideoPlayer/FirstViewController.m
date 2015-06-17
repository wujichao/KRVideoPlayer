//
//  FirstViewController.m
//  KRVideoPlayer
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

#import "FirstViewController.h"
#import "KRVideoPlayerController.h"

@interface FirstViewController ()

@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *b = [UIButton new];
    b.backgroundColor = [UIColor redColor];
    [b setTitle:@"remote" forState:UIControlStateNormal];
    [b sizeToFit];
    [b addTarget:self action:@selector(playRemoteVideo:) forControlEvents:UIControlEventTouchUpInside];
    b.center = CGPointMake(100, 200);
    [self.view addSubview:b];
    
    UIButton *b1 = [UIButton new];
    b1.backgroundColor = [UIColor redColor];
    [b1 setTitle:@"streaming" forState:UIControlStateNormal];
    [b1 sizeToFit];
    [b1 addTarget:self action:@selector(playStreamingVideo:) forControlEvents:UIControlEventTouchUpInside];
    b1.center = CGPointMake(100, 300);
    [self.view addSubview:b1];
    
    UIButton *b2 = [UIButton new];
    b2.backgroundColor = [UIColor redColor];
    [b2 setTitle:@"local" forState:UIControlStateNormal];
    [b2 sizeToFit];
    [b2 addTarget:self action:@selector(playLocalVideo:) forControlEvents:UIControlEventTouchUpInside];
    b2.center = CGPointMake(100, 400);
    [self.view addSubview:b2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playLocalVideo:(id)sender
{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    [self playVideoWithURL:videoURL];
}

- (IBAction)playRemoteVideo:(id)sender
{
    NSURL *videoURL = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    [self playVideoWithURL:videoURL];
}

- (IBAction)playStreamingVideo:(id)sender
{
    NSURL *videoURL = [NSURL URLWithString:@"http://219.232.160.141:5080/hls/c64024e7cd451ac19613345704f985fa.m3u8"];
    [self playVideoWithURL:videoURL];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

//
//  CAVDownloadManager.m
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/6/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import "CAVDownloadManager.h"

@interface CAVDownloadManager ()

@end

@implementation CAVDownloadManager

static CAVDownloadManager *cavSharedDownloadManager =nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(id)getSharedDownloadManager
{
    @synchronized(self)
    {
        if(!cavSharedDownloadManager)
        {
            cavSharedDownloadManager= [[CAVDownloadManager alloc]init];
        }
    }
    return cavSharedDownloadManager;
}

- (NSDictionary*)retrieveLabInformation{
    NSDictionary *cavInformation = [NSDictionary dictionaryWithContentsOfURL:
                                      [NSURL URLWithString:@"http://emerald.ipfw.edu:8080/cav-1.0.0/getLabInformation"]];
    
    NSArray *inUses = [cavInformation objectForKey:@"inUses"];
    NSArray *latitudes = [cavInformation objectForKey:@"latitudes"];
    NSArray *longitudes = [cavInformation objectForKey:@"longitudes"];
    NSArray *offs = [cavInformation objectForKey:@"offs"];
    NSArray *buildings = [cavInformation objectForKey:@"buildings"];
    NSArray *detailedDescriptions = [cavInformation objectForKey:@"detailedDescriptions"];
    NSArray *rooms = [cavInformation objectForKey:@"rooms"];
    NSArray *labStatsCodes = [cavInformation objectForKey:@"labStatsCodes"];
    NSArray *availableCapacities = [cavInformation objectForKey:@"availableCapacities"];
   
    return cavInformation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

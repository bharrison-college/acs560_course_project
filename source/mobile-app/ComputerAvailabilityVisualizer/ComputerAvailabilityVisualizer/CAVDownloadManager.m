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

- (NSMutableArray *)retrieveLabInformation{
    NSDictionary *cavInformation = [NSDictionary dictionaryWithContentsOfURL:
                                      [NSURL URLWithString:@"http://emerald.ipfw.edu:8080/cav-1.0.0/getLabInformation"]];

    NSArray *labStatsCodes = nil;
    if(cavInformation){
        labStatsCodes = [cavInformation objectForKey:@"labStatsCodes"];
    }
    
    CAVStoreManager *cavStoreManager = [CAVStoreManager getSharedStoreManager];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"CAVLab" inManagedObjectContext:cavStoreManager.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error1;
    NSArray *currentLabs = [cavStoreManager.managedObjectContext executeFetchRequest:request error:&error1];
    if(!labs){
        /* Error occurred */
    }
    
    NSMutableArray *labInfoList = [[NSMutableArray alloc] init];
    if(cavInformation && labStatsCodes && [labStatsCodes count] > 0){
        NSArray *inUses = [cavInformation objectForKey:@"inUses"];
        NSArray *latitudes = [cavInformation objectForKey:@"latitudes"];
        NSArray *longitudes = [cavInformation objectForKey:@"longitudes"];
        NSArray *offs = [cavInformation objectForKey:@"offs"];
        NSArray *buildings = [cavInformation objectForKey:@"buildings"];
        NSArray *detailedDescriptions = [cavInformation objectForKey:@"detailedDescriptions"];
        NSArray *rooms = [cavInformation objectForKey:@"rooms"];
        NSArray *availableCapacities = [cavInformation objectForKey:@"availableCapacities"];
        
        NSInteger c = 0;
        NSInteger size = [labStatsCodes count];
        for(; c < size; c++){
            
            CAVLab *lab = nil;
            for(CAVLab *currentLab in currentLabs){
                if([labStatsCodes[c] isEqualToString:currentLab.labStatsCode]){
                    lab = currentLab;
                    break;
                }
            }
            
            if(!lab){
                lab = [NSEntityDescription insertNewObjectForEntityForName:@"CAVLab" inManagedObjectContext:cavStoreManager.managedObjectContext];
            }
            
            lab.numInUse = inUses[c];
            lab.latitude = latitudes[c];
            lab.longitude = longitudes[c];
            lab.numOff = offs[c];
            lab.building = buildings[c];
            lab.detailDesc = detailedDescriptions[c];
            lab.room = rooms[c];
            lab.labStatsCode = labStatsCodes[c];
            lab.numAvailCapacity = availableCapacities[c];
            
            [labInfoList addObject:lab];
        }
        
        for(CAVLab *currentLab in currentLabs){
            bool labStillExists = false;
            
            NSInteger k = 0;
            NSInteger size = [labStatsCodes count];
            for(; k < size; k++){
                if([labStatsCodes[k] isEqualToString:currentLab.labStatsCode]){
                    labStillExists = true;
                    break;
                }
            }
            
            if(!labStillExists){
                [cavStoreManager.managedObjectContext deleteObject:currentLab];
            }
        }
        
        NSError *error;
        [cavStoreManager.managedObjectContext save:&error];
    }
    else{
        if(currentLabs && [currentLabs count] > 0){
            [labInfoList addObjectsFromArray:currentLabs];
        }
    }
    
    return labInfoList;
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

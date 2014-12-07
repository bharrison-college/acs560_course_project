//
//  CAVDownloadManager.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/6/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAVStoreManager.h"
#import "CAVLab.h"
#import "CAVParticle.h"

@interface CAVDownloadManager : UIViewController
+ (id)getSharedDownloadManager;
- (NSMutableArray *)retrieveLabInformation;
@end

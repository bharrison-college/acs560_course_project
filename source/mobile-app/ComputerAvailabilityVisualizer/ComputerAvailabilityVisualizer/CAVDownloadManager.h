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

@interface CAVDownloadManager : UIViewController
@property (atomic, strong)NSMutableArray *labInfoList;

+ (id)getSharedDownloadManager;
- (void)updateLabInformation;
@end

//
//  CAVDownloadManager.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/6/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAVDownloadManager : UIViewController
+ (id)getSharedDownloadManager;
- (NSDictionary*)retrieveLabInformation;
@end

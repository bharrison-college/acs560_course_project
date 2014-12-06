//
//  CAVLab.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/6/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CAVLab : NSManagedObject

@property (nonatomic, retain) NSString * detailDesc;
@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSNumber * numOff;
@property (nonatomic, retain) NSNumber * numInUse;
@property (nonatomic, retain) NSNumber * numAvailCapacity;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * labStatsCode;
@property (nonatomic, retain) NSManagedObject *particle;

@end

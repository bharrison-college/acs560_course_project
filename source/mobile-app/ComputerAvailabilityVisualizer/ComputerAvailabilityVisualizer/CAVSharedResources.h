//
//  CAVSharedLabsStore.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAVSharedResources : NSObject
@property (nonatomic, strong)NSString *currentDetailViewLabStatsCode;

+(id)getSharedResources;

@end

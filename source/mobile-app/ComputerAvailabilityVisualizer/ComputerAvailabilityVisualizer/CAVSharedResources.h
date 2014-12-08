//
//  CAVSharedLabsStore.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SpriteKit/SpriteKit.h>
#import "CAVPointAnnotationView.h"


@interface CAVSharedResources : NSObject
@property (nonatomic, strong)NSString *currentDetailViewLabStatsCode;
@property (nonatomic)CLLocationDistance currentDistanceToLab;

+(id)getSharedResources;

@end

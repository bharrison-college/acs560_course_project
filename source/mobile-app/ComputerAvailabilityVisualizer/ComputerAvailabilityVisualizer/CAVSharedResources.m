//
//  CAVSharedLabsStore.m
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 11/2/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import "CAVSharedResources.h"

@implementation CAVSharedResources
static CAVSharedResources *sharedResources = nil; // Static instance of the singleton

/* This method returns a shared instance of the MAMSharedResources class */
+(id)getSharedResources
{
    @synchronized(self)
    {
        if(!sharedResources)
        {
            sharedResources = [[CAVSharedResources alloc]init];
        }
    }
    
    return sharedResources;
}

- (void)print{
    NSLog(@"hellow rold ");
}
@end

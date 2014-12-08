//
//  CAVPointAnnotationView.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/8/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "ZSPinAnnotation.h"
#import "CAVSceneView.h"

@interface CAVPointAnnotationView : ZSPinAnnotation
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end

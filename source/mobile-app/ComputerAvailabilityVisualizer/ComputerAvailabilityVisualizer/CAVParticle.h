//
//  CAVParticle.h
//  ComputerAvailabilityVisualizer
//
//  Created by Blake Harrison on 12/6/14.
//  Copyright (c) 2014 Blake Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAVLab;

@interface CAVParticle : NSManagedObject

@property (nonatomic, retain) NSNumber * emissionAngle;
@property (nonatomic, retain) NSNumber * emissionAngleRange;
@property (nonatomic, retain) NSNumber * numParticlesToEmit;
@property (nonatomic, retain) NSNumber * birthRate;
@property (nonatomic, retain) NSNumber * blueColor;
@property (nonatomic, retain) NSNumber * greenColor;
@property (nonatomic, retain) NSNumber * lifetime;
@property (nonatomic, retain) NSNumber * lifetimeRange;
@property (nonatomic, retain) NSNumber * redColor;
@property (nonatomic, retain) NSNumber * rotation;
@property (nonatomic, retain) NSNumber * rotationRange;
@property (nonatomic, retain) NSNumber * rotationSpeed;
@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) NSNumber * scaleRange;
@property (nonatomic, retain) NSNumber * scaleSequence;
@property (nonatomic, retain) NSNumber * scaleSpeed;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * speedRange;
@property (nonatomic, retain) NSNumber * zPositionSpeed;
@property (nonatomic, retain) NSNumber * xAcceleration;
@property (nonatomic, retain) NSNumber * xPosition;
@property (nonatomic, retain) NSNumber * xPositionRange;
@property (nonatomic, retain) NSNumber * xPositionSpeed;
@property (nonatomic, retain) NSNumber * yAcceleration;
@property (nonatomic, retain) NSNumber * yPosition;
@property (nonatomic, retain) NSNumber * yPositionRange;
@property (nonatomic, retain) NSNumber * yPositionSpeed;
@property (nonatomic, retain) NSNumber * zAcceleration;
@property (nonatomic, retain) NSNumber * zPosition;
@property (nonatomic, retain) NSNumber * zPositionRange;
@property (nonatomic, retain) CAVLab *lab;

@end

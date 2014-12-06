//
//  CRStoreManager.h
//  MobileCardReader
//
//  Created by Blake Harrison on 7/11/14.
//  Copyright (c) 2014 Indiana University-Purdue University Fort Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CAVStoreManager : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(id)getSharedStoreManager;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

//
//  AppDelegate.h
//  CarValet
//
//  Created by 黄彬杨 on 2016/12/12.
//  Copyright © 2016年 黄彬杨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#define MyModelURLFile          @"CarValet"
#define MySQLDataFileName       @"CarValet.sqlite"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext
*managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel
*managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator
*persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

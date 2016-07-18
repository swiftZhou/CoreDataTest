//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by 周海 on 16/7/14.
//  Copyright © 2016年 zhouhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//                                      //NSManagedObjectContext 核心的数据管理类通过操作它来执行对数据的相关操作
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//                                      //NSManagedObjectModel 对应数据模型，即创建的.xcdatamodeld文件
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//                                      //NSPersistentStoreCoordinator 对应数据模型，
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//NSManagedObject

@end


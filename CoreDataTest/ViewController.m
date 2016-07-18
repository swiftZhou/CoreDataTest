//
//  ViewController.m
//  CoreDataTest
//
//  Created by 周海 on 16/7/14.
//  Copyright © 2016年 zhouhai. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Student.h"
@interface ViewController ()
{
    AppDelegate *_appDelegate;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    
    //--------------------
   
    [self insertData];
    [self selectData];
    
    //--------------------
    /*
     [self selectData];
    [self deleteData];
     */
    //--------------------
    //[self selectData];
    //[self updateData];
}

#pragma mark - 插入数据
- (void)insertData{
    //通过实体获取数据对象
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_appDelegate.managedObjectContext];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_appDelegate.managedObjectContext];
    student.score = @250;
    
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:student];
    //设置数据
    person.name = @"周小海";
    person.age = @25;
    person.student = set;
    
    //进行存储
    NSError *error = nil;
    if([_appDelegate.managedObjectContext save:&error]){
    
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败:Error= %@",error);
    }
}
#pragma mark - 查询数据
/*
CoreData中通过查询请求来对数据进行查询操作，查询请求由NSFetchRequest来进行管理和维护。
 NSFetchRequest主要提供两个方面的查询服务：
 
 1.提供范围查询的相关功能
 
 2.提供查询结果返回类型与排序的相关功能
 
 NSFetchRequest中常用方法如下
 */
- (void)selectData{
    //创建一条查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    //设置条件为姓名等于"周海"的数据,不设置条件默认查询所有数据
//    [request setPredicate:[NSPredicate predicateWithFormat:@"age <= %@",@28]];
    //进行查询操作
    
    NSError *error = nil;
    NSArray *dataArr = [_appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"%@,error==%@",dataArr,error);
    
    if (!error) {
        for (Person *p in dataArr) {

            NSSet *set = p.student;
            NSLog(@"name==%@,age==%@,score==%@",p.name,p.age,set);
    }
    }
}

#pragma mark -删除数据
- (void)deleteData{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    //设置要删除的字段
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@",@"周海"]];
    
    NSArray *arr = [_appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (NSManagedObject *obj in arr) {
        [_appDelegate.managedObjectContext deleteObject:obj];
    }
    
    [self selectData];
}
#pragma mark - 更新数据
- (void)updateData{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    //设置要更新的是哪个数据 更新年龄为0的数据
    [request setPredicate:[NSPredicate predicateWithFormat:@"age == %@",@0]];
    NSArray *arr = [_appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    for (Person *p in arr) {
        [p setName:@"行修改"];
        [p setAge:@120];
//        p.student.score = @50;
    }
    //记得保存
     NSError *savingError = nil;
    if ([_appDelegate.managedObjectContext save:&savingError]) {
        NSLog(@"修改成功");
    } else{
        NSLog(@"修改失败");
    }
    //
    [self selectData];
}
@end

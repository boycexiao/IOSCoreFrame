//
//  Person.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-27.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * isMale;
@property (nonatomic, retain) NSSet *books;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBooksObject:(NSManagedObject *)value;
- (void)removeBooksObject:(NSManagedObject *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end

//
//  PhotoModel.m
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        _name = name;
    }
    return self;
}

-(UIImage*)image
{
    return [UIImage systemImageNamed:self.name];
}

+(nonnull NSArray<PhotoModel*>*)generatePhotoItemsForCount:(NSUInteger)numberOfItems
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:numberOfItems];
    for (NSUInteger i = 0; i < numberOfItems; i++)
    {
        PhotoModel *aItem = [self generatePhotoItem];
        [items addObject:aItem];
    }
    return items;
}

#pragma mark - Private
static NSString *LastName = @"";

+(NSArray<NSString*>*)names
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < 25; i++)
    {
        NSString *name = [NSString stringWithFormat:@"%lu.square",i];
        [array addObject:name];
    }
    return array;
}

+(NSString*)randomNameFromNames:(NSArray<NSString*>*)namesArray
{
    NSUInteger randomIndex = arc4random() % namesArray.count;
    return [namesArray objectAtIndex:randomIndex];
}

+(PhotoModel*)generatePhotoItem
{
    // Get a name that is different from the last name.
    NSArray *namesArray = self.names;
    NSString *name = [self randomNameFromNames:namesArray];
    
    while (name == LastName)
    {
        name = [self randomNameFromNames:namesArray];
    }
    LastName = name;
    return [[PhotoModel alloc]initWithName:name];
}

@end

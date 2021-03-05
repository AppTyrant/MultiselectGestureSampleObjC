//
//  FillerModel.m
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
//

#import "FillerModel.h"

@implementation FillerModel

+(NSArray<FillerModel*>*)generateFillerItemsForCount:(NSUInteger)numberOfItems
{
    NSMutableArray *theItems = [NSMutableArray array];
    for (NSUInteger i = 0; i < numberOfItems; i++)
    {
        FillerModel *random = [FillerModel generateFillerItem];
        [theItems addObject:random];
    }
    return theItems;
}

-(instancetype)initWithTitle:(NSString*)title description:(NSString*)description
{
    self = [super init];
    if (self)
    {
        _title = title;
        _descriptionText = description;
    }
    return self;
}

#pragma mark - Private
+(NSString*)_randomTextFromStringArray:(NSArray<NSString*>*)array
{
    NSUInteger randomIndex = arc4random() % array.count;
    return [array objectAtIndex:randomIndex];
}

+(NSArray<NSString*>*)newLinesSeparatedStringsFromFileAtURL:(NSURL*)fileURL
{
    NSString *stringRaw = [[NSString alloc]initWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
    NSArray<NSString*>*titles = [stringRaw componentsSeparatedByString:@"\n"];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings)
    {
        if ([[evaluatedObject stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] isEqualToString:@""])
        {
            return NO;
        }
        return YES;
    }];
    
    NSArray *theTitles = [titles filteredArrayUsingPredicate:predicate];
    if (theTitles.count > 0)
    {
        return theTitles;
        
    }
    else
    {
        return @[@"<unknown>"];
    }
}

+(NSArray<NSString*>*)allTitles
{
    static NSArray<NSString*>*Titles = nil;
    if (Titles == nil)
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *titlesURL = [bundle URLForResource:@"lipsum_titles" withExtension:@"txt"];
        Titles = [self newLinesSeparatedStringsFromFileAtURL:titlesURL];
    }
    return Titles;
}

+(NSArray<NSString*>*)allDescriptions
{
    static NSArray<NSString*>*Descriptions = nil;
    if (Descriptions == nil)
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *titlesURL = [bundle URLForResource:@"lipsum_descriptions" withExtension:@"txt"];
        Descriptions = [self newLinesSeparatedStringsFromFileAtURL:titlesURL];
    }
    return Descriptions;
}

+(FillerModel*)generateFillerItem
{
    NSString *title = [self _randomTextFromStringArray:self.allTitles];
    NSString *descriptionText = [self _randomTextFromStringArray:self.allDescriptions];
    return [[FillerModel alloc]initWithTitle:title description:descriptionText];
}

@end

//
//  FillerModel.h
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface FillerModel : NSObject

@property (nonnull,nonatomic,strong,readonly) NSString *title;
@property (nonnull,nonatomic,strong,readonly) NSString *descriptionText;

+(nonnull NSArray<FillerModel*>*)generateFillerItemsForCount:(NSUInteger)numberOfItems;

@end



//
//  PhotoModel.h
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject

@property (nonnull,nonatomic,strong,readonly) NSString *name;
@property (nonnull,nonatomic,strong,readonly) UIImage *image;

+(nonnull NSArray<PhotoModel*>*)generatePhotoItemsForCount:(NSUInteger)numberOfItems;

@end

//
//  CollectionViewCell.h
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//

#import <UIKit/UIKit.h>

@class PhotoModel;

@interface CollectionViewCell : UICollectionViewCell

@property (nonnull,class,nonatomic,copy,readonly) NSString *reuseIdentifier;

@property (nullable,nonatomic,weak) IBOutlet UIImageView *imageView;
@property  (nullable,nonatomic,weak) IBOutlet UIView *imageViewOverlay;
@property (nullable,nonatomic,weak) IBOutlet UIImageView *imageViewSelected;
@property (nullable,nonatomic,weak) IBOutlet UIImageView *imageViewUnselected;

-(void)configureCellWithPhotoModel:(nonnull PhotoModel*)photoModel showSelectionIcons:(BOOL)showSelectionIcons;

@end

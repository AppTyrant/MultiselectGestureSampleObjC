//
//  CollectionViewCell.m
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//

#import "CollectionViewCell.h"
#import "PhotoModel.h"

@interface CollectionViewCell()

@property (nonatomic) BOOL showSelectionIcons;

@end

@implementation CollectionViewCell


-(void)awakeFromNib
{
    [super awakeFromNib];
    // Turn `imageViewSelected` into a circle to make its background
    // color act as a border around the checkmark symbol.
    self.imageViewSelected.layer.cornerRadius = self.imageViewSelected.bounds.size.width / 2;
    self.imageViewUnselected.layer.cornerRadius = self.imageViewSelected.bounds.size.width / 2;
}

-(void)configureCellWithPhotoModel:(PhotoModel*)photoModel showSelectionIcons:(BOOL)showSelectionIcons
{
    self.showSelectionIcons = showSelectionIcons;
    UIImage *image = photoModel.image;
    if (image != nil)
    {
        self.imageView.image = image;
    }
    [self showSelectionOverlay];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.selected = NO;
    self.showSelectionIcons = NO;
    [self showSelectionOverlay];
}

-(void)setSelected:(BOOL)selected
{
    BOOL currentSelected = self.isSelected;
    [super setSelected:selected];
    if (selected != currentSelected)
    {
        [self showSelectionOverlay];
        [self setNeedsLayout];
    }
}

-(void)showSelectionOverlay
{
    CGFloat alpha = (self.isSelected && self.showSelectionIcons) ? 1.0 : 0.0;
    self.imageViewOverlay.alpha = alpha;
    self.imageViewSelected.alpha = alpha;
    self.imageViewUnselected.alpha = self.showSelectionIcons ? 1.0 : 0.0;
}

+(NSString*)reuseIdentifier
{
    static NSString *const theID = @"reuseIdentifier";
    return theID;
}
 
@end

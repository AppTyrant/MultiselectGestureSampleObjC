//
//  CollectionViewController.m
//  MultiselectGestureSampleObjC
//
//  Created by ANTHONY CRUZ on 1/27/21.
//  Copyright © 2021 App Tyrant Corp. All rights reserved.
//

#import "CollectionViewController.h"
#import "PhotoModel.h"
#import "CollectionViewCell.h"

@interface CollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray<PhotoModel*>*photos;
@property (nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic) BOOL isPad;
@property (nonatomic,readonly) UIEdgeInsets sectionInsets;

@end

@implementation CollectionViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.isPad = (self.view.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad);
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = NO;
    [self setEditing:NO animated:NO];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    if ([flowLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        flowLayout.minimumLineSpacing = self.sectionInsets.left;
        flowLayout.minimumInteritemSpacing = self.sectionInsets.left;
        flowLayout.sectionInset = self.sectionInsets;
        flowLayout.itemSize = self.itemSize;
    }
    
    [self updateUserInterface];
}

-(void)updateUserInterface
{
    UIBarButtonItem *button = self.navigationItem.rightBarButtonItem;
    button.title = (self.isEditing) ? @"Done" : @"Select";
}

-(void)clearSelectedItemsAnimated:(BOOL)animated
{
    NSArray *indexPathsForSelectedItems = self.collectionView.indexPathsForSelectedItems;
    for (NSIndexPath *aPath in indexPathsForSelectedItems)
    {
        [self.collectionView deselectItemAtIndexPath:aPath animated:animated];
    }
    [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
}

-(CGSize)itemSize
{
    NSInteger itemsPerRow = (self.isPad) ? 10 : 3;
    CGFloat paddingSpace = self.sectionInsets.left * (itemsPerRow + 1);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth / itemsPerRow;
    return CGSizeMake(widthPerItem, widthPerItem);
}

-(UIEdgeInsets)sectionInsets
{
    return UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
}

-(NSArray<PhotoModel*>*)photos
{
    if (_photos == nil)
    {
        _photos = [PhotoModel generatePhotoItemsForCount:100];
    }
    return _photos;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (self.isEditing == editing)
    {
        // Nothing to do. The caller didn't change the editing flag value.
        return;
    }
    
    if (!editing) { self.title = @""; }
    [super setEditing:editing animated:animated];
    self.collectionView.editing = editing;
    self.collectionView.allowsMultipleSelection = editing;
    self.collectionView.allowsMultipleSelectionDuringEditing = editing;

    [self clearSelectedItemsAnimated:YES];
    [self updateUserInterface];
}


-(IBAction)toggleSelectionMode:(id)sender
{
    // Toggle selection state.
    [self setEditing:!self.isEditing animated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}


-(__kindof UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                         cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCell.reuseIdentifier forIndexPath:indexPath];
    
    PhotoModel *photo = [self.photos objectAtIndex:indexPath.row];
    [cell configureCellWithPhotoModel:photo showSelectionIcons:collectionView.allowsMultipleSelection];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    if (collectionView.isEditing)
    {
        self.title = [NSString stringWithFormat:@"%lu selected",collectionView.indexPathsForSelectedItems.count];
    }
    else
    {
        // Automatically deselect items when the app isn't in edit mode.
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

-(void)collectionView:(UICollectionView*)collectionView didDeselectItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (collectionView.isEditing && collectionView.indexPathsForSelectedItems.count > 0)
    {
        self.title = [NSString stringWithFormat:@"%lu selected",collectionView.indexPathsForSelectedItems.count];
    }
    else
    {
        self.title = @"";
    }
}

-(BOOL)collectionView:(UICollectionView*)collectionView
shouldBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    // Returning `YES` automatically sets `collectionView.allowsMultipleSelection`
    // to `YES`. The app sets it to `NO` after the user taps the Done button.
    return YES;
}

-(void)collectionView:(UICollectionView*)collectionView didBeginMultipleSelectionInteractionAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    // Replace the Select button with Done, and put the
    // collection view into editing mode.
    [self setEditing:YES animated:YES];
}

-(void)collectionViewDidEndMultipleSelectionInteraction:(UICollectionView *)collectionView
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end

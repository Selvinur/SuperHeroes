//
//  CharacterCustomCell.h
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 20.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgCh;
@property (strong, nonatomic) IBOutlet UILabel *lblHeroName;

@end

NS_ASSUME_NONNULL_END

//
//  ComicsCustomCell.h
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 22.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicsCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgComics;
@property (strong, nonatomic) IBOutlet UILabel *lblComics;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@end

NS_ASSUME_NONNULL_END

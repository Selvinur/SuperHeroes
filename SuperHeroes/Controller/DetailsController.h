//
//  DetailsController.h
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 22.11.2021.
//

#import <UIKit/UIKit.h>
#import "SuperHeroes.h"
#import "AFNetworking.h"
#import "Comics.h"
#import "UIImageView+AFNetworking.h"
#import "ComicsCustomCell.h"
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *comicsArray;
@property Comics *cmc;
@property SuperHeroes *obj;

@end

NS_ASSUME_NONNULL_END

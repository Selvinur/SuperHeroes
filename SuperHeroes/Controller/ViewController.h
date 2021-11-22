//
//  ViewController.h
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 20.11.2021.
//

#import <UIKit/UIKit.h>
#import "CharacterCustomCell.h"
#import "SuperHeroes.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsController.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *heroesArray;
@property UIImageView *heroesImage;
@property SuperHeroes *superHero;
@property NSString *apiKey;
@property NSString *timeStamp;
@property NSString *hashKey;
@property NSString *baseURL;
@property NSString *limit;

@end


//
//  ViewController.m
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 20.11.2021.
//

#import "ViewController.h"


#define API_KEY @"3e9a944d71a936a9971eabc33b3af197"
#define TIME_STAMP @"1"
#define HASH_KEY @"49e343093d80dd75fd2c43a4065cf3e6"
#define LIMIT @"100"

@interface ViewController ()
@property (nonatomic) int selectedIndex;
@end

@implementation ViewController
@synthesize superHero, heroesArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self init];
    [self serviceCall];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
- (id)init{
    if (self = [super init]) {
        self.apiKey=API_KEY;
        self.timeStamp=TIME_STAMP;
        self.hashKey=HASH_KEY;
        self.baseURL=@"https://gateway.marvel.com:443";
        self.limit=LIMIT;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return heroesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CharacterCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"characterCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CharacterCustomCell" bundle:nil] forCellReuseIdentifier:@"characterCell"];
    cell =[tableView dequeueReusableCellWithIdentifier:@"characterCell"];
    
    SuperHeroes *h =[heroesArray objectAtIndex:indexPath.row];
    cell.lblHeroName.text=h.heroName;
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 5)];
        separatorLineView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separatorLineView];
    cell.imgCh.layer.cornerRadius=10;
    [cell.imgCh setImageWithURL:[NSURL URLWithString:h.heroImg] placeholderImage:[UIImage imageNamed:h.heroName]];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex=indexPath.row;
    NSObject *obj=[heroesArray objectAtIndex:_selectedIndex];
    [self performSegueWithIdentifier:@"heroDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailsController *dc = [segue destinationViewController];
    dc.obj=[heroesArray objectAtIndex:_selectedIndex];
}

-(void) getRequest:(NSString *)requestURL completion:(void (^)(NSDictionary *, NSError *)) completion{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] init];
    [manager GET:requestURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *operation, id  _Nullable responseObject) {
        if(completion) completion((NSDictionary *)responseObject[@"data"][@"result"],nil);
        [self mapping:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion) completion(nil,error);
    }];
}

-(void) mapping:(NSMutableDictionary *)response{
    NSDictionary *data = [response valueForKey:@"data"];
    NSArray *results = [data valueForKey:@"results"];
    heroesArray= [NSMutableArray arrayWithCapacity:results.count];
    for(NSDictionary *item in results){
        SuperHeroes *hero=[[SuperHeroes alloc] init];
        hero.heroId=[item valueForKey:@"id"];
        hero.heroName=[item valueForKey:@"name"];
        NSDictionary *thumbnail = [item valueForKey:@"thumbnail"];
        NSString *thumbnailUrl = [NSString stringWithFormat:@"%@.%@", [thumbnail valueForKey:@"path"], [thumbnail valueForKey:@"extension"]];
        hero.heroImg = [thumbnailUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
        
        [heroesArray addObject:hero];
    }
    [self.tableView reloadData];
}

- (void)serviceCall {
    [self getRequest:[NSString stringWithFormat:@"%@/v1/public/characters?limit=%@&ts=%@&apikey=%@&hash=%@",self.baseURL,self.limit,self.timeStamp,self.apiKey,self.hashKey] completion:^(NSDictionary *_Nonnull dictionary, NSError *_Nonnull error) {
    }];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(self.heroesArray.count>1){
//        if(indexPath.row == self.heroesArray.count-1){
//            pagesNumber=pagesNumber+1;
//
////            [self serviceCall];
//        }
//    }
//}

@end

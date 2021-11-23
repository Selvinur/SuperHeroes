//
//  DetailsController.m
//  SuperHeroes
//
//  Created by Selvinur Yağışan on 22.11.2021.
//

#import "DetailsController.h"

@interface DetailsController ()

@end

@implementation DetailsController
@synthesize obj;
@synthesize comicsArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self serviceCall];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return comicsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    UILabel *lbl=[UILabel new];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    lbl.text=obj.heroName;
    return lbl.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComicsCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"comicsCell"];
    [tableView registerNib:[UINib nibWithNibName:@"ComicsCustomCell" bundle:nil] forCellReuseIdentifier:@"comicsCell"];
    cell =[tableView dequeueReusableCellWithIdentifier:@"comicsCell"];
    
    Comics *c =[comicsArray objectAtIndex:indexPath.row];
   
    if(c.comicsDesc==nil ||  [c.comicsDesc isEqualToString:@""]){
        cell.lblComics.text=@"Description Not Found";
    }else
        cell.lblComics.text=c.comicsDesc;
    if(c.comicsTitle==nil ||  [c.comicsTitle isEqualToString:@""])
    cell.lblTitle.text=@"title hata";
    else{
    cell.lblTitle.text=c.comicsTitle;
    cell.lblTitle.adjustsFontSizeToFitWidth=YES;
    }
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 5)];
    separatorLineView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:separatorLineView];
    if(c.comicsImg==nil || [c.comicsImg isEqualToString:@""]){
        NSLog(@"HATA image");
    }
    
    else{
        cell.imgComics.layer.cornerRadius=10;
        [cell.imgComics setImageWithURL:[NSURL URLWithString:c.comicsImg]];
        
    }
        return cell;
}

-(void)serviceCall{
    ViewController *controller=[ViewController new];
    [self getRequest:[NSString stringWithFormat:@"%@/v1/public/characters/%@/comics?limit=5&ts=%@&apikey=%@&hash=%@",controller.baseURL,obj.heroId, controller.timeStamp,controller.apiKey,controller.hashKey] completion:^(NSDictionary *_Nonnull dictionary, NSError *_Nonnull error) {
    }];
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
    comicsArray= [NSMutableArray arrayWithCapacity:results.count];
   
    for(NSDictionary *item in results){
        Comics *comics=[[Comics alloc] init];
        comics.comicsId=[item valueForKey:@"id"];
        comics.comicsDesc=[item valueForKey:@"description"];
        comics.comicsTitle=[item valueForKey:@"title"];
        NSDictionary *thumbnail = [item valueForKey:@"thumbnail"];
        NSString *thumbnailUrl = [NSString stringWithFormat:@"%@.%@", [thumbnail valueForKey:@"path"], [thumbnail valueForKey:@"extension"]];
        comics.comicsImg = [thumbnailUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
        
        [comicsArray addObject:comics];
    }
    [self.tableView reloadData];
}
@end

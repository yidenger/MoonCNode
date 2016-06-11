//
//  MoonHomeTableViewController.m
//  MoonCNode
//
//  Created by seth on 16/6/1.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonHomeTableViewController.h"
#import <AFNetworking.h>
#import "MoonTopicModel.h"
#import "MoonTopicCell.h"
#import "MoonTopicFrame.h"
#import "MoonPerson.h"


@interface MoonHomeTableViewController ()

@property(nonatomic, strong)NSMutableArray *topicArr;

@end

@implementation MoonHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getTopicDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"number: %lu", (unsigned long)self.topicArr.count);
    return self.topicArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"topicCell";
    
    MoonTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[MoonTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // Configure the cell...
    MoonTopicFrame *topicFrame = self.topicArr[indexPath.row];
    cell.topicFrame = topicFrame;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoonTopicFrame *topicFrame = self.topicArr[indexPath.row];
    return topicFrame.cellHeight;
}


//懒加载
-(NSMutableArray *)topicArr{
    
    if (!_topicArr) {
        _topicArr = [NSMutableArray array];
    }
    return  _topicArr;
}

/**
 *  从服务器获取话题数据
 */
-(void)getTopicDataFromServer{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"https://cnodejs.org/api/v1/topics";
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *session, NSDictionary *responseObj){
        NSLog(@"获取话题数据成功");
        NSArray *topicArr = responseObj[@"data"];
        NSLog(@"topicArr count: %ld", [topicArr count]);
        for (NSInteger i = 0; i < topicArr.count; i++) {
            MoonTopicModel *topicModel = [[MoonTopicModel alloc]init];
            NSDictionary *topicDic = [topicArr objectAtIndex:i];
            topicModel.topic_id = topicDic[@"id"];
            topicModel.author_id = topicDic[@"author_id"];
            topicModel.tab = topicDic[@"tab"];
            topicModel.content = topicDic[@"content"];
            topicModel.title = topicDic[@"title"];
            topicModel.last_reply_at = topicDic[@"last_reply_at"];
            
            topicModel.good = [topicDic[@"good"] boolValue];
            topicModel.top = [topicDic[@"top"] boolValue];
            topicModel.reply_count = [topicDic[@"reply_count"] integerValue];
            topicModel.visit_count = [topicDic[@"visit_count"] integerValue];
            topicModel.create_at = topicDic[@"create_at"];
//            topicModel.person.loginName = topicDic[@"author"][@"loginname"];
//            topicModel.person.avatar_url = topicDic[@"author"][@"avatar_url"];
            
            MoonPerson *person = [[MoonPerson alloc]init];
            NSMutableDictionary *tmp = topicDic[@"author"];
            person.loginName = tmp[@"loginname"];
            person.avatar_url = tmp[@"avatar_url"];
            
            topicModel.person = person;
            MoonTopicFrame *topicFrame = [[MoonTopicFrame alloc]init];
            topicFrame.topic = topicModel;
            [self.topicArr addObject:topicFrame];
//            NSLog(@"%ld", i);
        }
//        NSLog(@"%@", self.topicArr);
        [self.tableView reloadData];
    
    } failure:^(NSURLSessionDataTask *session, NSError *error){
        NSLog(@"出错啦:%@", error);
    }];

}

@end

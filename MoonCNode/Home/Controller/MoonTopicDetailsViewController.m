//
//  MoonTopicDetailsViewController.m
//  MoonCNode
//
//  Created by seth on 16/6/9.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTopicDetailsViewController.h"
#import "MoonTopicDetailsCell.h"
#import "MoonTopicDetailsFrame.h"
#import "MoonTopicReplyCell.h"
#import <AFNetworking.h>
#import "MoonTopicReplyFrame.h"

@interface MoonTopicDetailsViewController ()

@property(nonatomic, strong)NSMutableArray *replyArr;
@property(nonatomic, strong)NSMutableArray *replyFrameArr;

@end

@implementation MoonTopicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //去掉header黏性效果
    self.tableView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    
    [self getReplyData];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeight:) name:@"webViewHeight" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeight:) name:@"getDoneHeight" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeHeight:(NSNotification *)notification{
//    [self.tableView reloadData];
    NSLog(@"tableview get notification...");
    self.detailsHeight = [notification.object floatValue];
    NSLog(@"******detailsHeight: %f", self.detailsHeight);
//    [self.tableView beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
//    [self.tableView endUpdates];
    
//    [self.tableView reloadSections:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 1;
    }
    else{
        return self.replyArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSLog(@"indexPath: %@", indexPath);
    
    if (indexPath.section == 0) {
        
        static NSString *identifier = @"topicDetailContentCell";
        
        MoonTopicDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[MoonTopicDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        
        MoonTopicDetailsFrame *topicDetailsFrame = [[MoonTopicDetailsFrame alloc]init];
        topicDetailsFrame.topic = self.topic;
        cell.topicDetailFrame = topicDetailsFrame;
//        cell.backgroundColor = [UIColor greenColor];
        NSLog(@"#######topicDetailsCell height: %f", cell.cellHeight);
//        [topicDetailsFrame addObserver:self forKeyPath:@"cellHeight" options:NSKeyValueObservingOptionNew context:nil];

        return  cell;
    }
    else{
        static NSString *replyIdentifier = @"replyIdentifierCell";
        MoonTopicReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:replyIdentifier];
        if (nil == cell) {
            cell = [[MoonTopicReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:replyIdentifier];
        }
//        cell.textLabel.text = @"回复回复";
        MoonTopicReplyFrame *replyFrame = self.replyFrameArr[indexPath.row];
        cell.replyFrame = replyFrame;
        
        if (cell.contentWebViewHeight > 5 && replyFrame.cellHeight != cell.cellHeight) {
            replyFrame.cellHeight = cell.cellHeight;
            [self.replyFrameArr replaceObjectAtIndex:indexPath.row withObject:replyFrame];
        }
    
        return cell;
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"*****indexPath: %ld, %ld", indexPath.section, indexPath.row);
    if (indexPath.section == 0) {
        MoonTopicDetailsFrame *topicDetailsFrame = [[MoonTopicDetailsFrame alloc]init];
        topicDetailsFrame.topic = self.topic;
        
        NSLog(@"cell height: %f", topicDetailsFrame.cellHeight);
        if (self.detailsHeight > 0) {
            return self.detailsHeight;
        }
        return topicDetailsFrame.cellHeight;
    }
    else{
        MoonTopicReplyFrame *replyFrame = self.replyFrameArr[indexPath.row];
        return replyFrame.cellHeight;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"you click details cell...");
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        UILabel *replyCountLabel = [[UILabel alloc]init];
        NSString *replyCountText = [NSString stringWithFormat:@"%lu条回复", (unsigned long)self.replyArr.count];
        NSRange range = NSMakeRange(0, [NSString stringWithFormat:@"%lu", self.replyArr.count].length);
        NSMutableAttributedString *attr= [[NSMutableAttributedString alloc]initWithString:replyCountText];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:66/255.0 green:185/255.0 blue:138/255.0 alpha:1] range:range];
        replyCountLabel.attributedText = attr;
        replyCountLabel.frame = CGRectMake(13, 10, 120, 30);
        [headView addSubview:replyCountLabel];
        
        return headView;
    }
    
    return nil;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        return [NSString stringWithFormat:@"%lu条回复", self.replyArr.count];
//    }
//    return nil;
//}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"kvo...");
//    if ([keyPath isEqualToString:@"cellHeight"]) {
//        [self.tableView reloadData];
//    }
//}

#pragma mark - Reply Data

-(NSMutableArray *)replyArr{
    if (!_replyArr) {
        _replyArr = [NSMutableArray array];
    }
    return _replyArr;
}
-(NSMutableArray *)replyFrameArr{
    if (!_replyFrameArr) {
        _replyFrameArr = [NSMutableArray array];
    }
    return _replyFrameArr;
}

/**
 *  从服务器获取回复数据
 */
-(void)getReplyData{
    NSString *topic_id = self.topic.topic_id;
    NSString *urlStr = [NSString stringWithFormat:@"https://cnodejs.org/api/v1/topic/%@", topic_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *session, NSDictionary *reponseObj){
        NSLog(@"获取回复数据成功");
        NSDictionary *reponseData = reponseObj[@"data"];
        NSArray *replyArr = reponseData[@"replies"];
        for (int i = 0; i < replyArr.count; i++) {
            NSDictionary *replyData = replyArr[i];
            MoonTopicReplyModel *replyModel = [[MoonTopicReplyModel alloc]init];
            replyModel.create_id = replyData[@"id"];
            replyModel.content = replyData[@"content"];
            replyModel.create_at = replyData[@"create_at"];
            replyModel.reply_id = replyData[@"reply_id"];
            replyModel.ups = replyData[@"ups"];
            NSDictionary *personData = replyData[@"author"];
            MoonPerson *person = [[MoonPerson alloc]init];
            person.avatar_url = personData[@"avatar_url"];
            person.loginName = personData[@"loginname"];
            replyModel.person = person;
            
            [self.replyArr addObject:replyModel];
            
            MoonTopicReplyFrame *replyFrame= [[MoonTopicReplyFrame alloc]init];
            replyFrame.replyModel = replyModel;
            [self.replyFrameArr addObject:replyFrame];
            
        }
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *session, NSError *error){
        NSLog(@"%@", error);
    }];
}

-(void)dealloc{
    NSLog(@"delloc...");
    
}

@end

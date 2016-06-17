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

@interface MoonTopicDetailsViewController ()

@end

@implementation MoonTopicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        return 10;
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
        
//        [topicDetailsFrame addObserver:self forKeyPath:@"cellHeight" options:NSKeyValueObservingOptionNew context:nil];
        return  cell;
    }
    else{
        static NSString *replyIdentifier = @"replyIdentifierCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:replyIdentifier];
        if (nil == cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:replyIdentifier];
        }
        cell.textLabel.text = @"回复回复";
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
        return 40;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"you click details cell...");
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"kvo...");
//    if ([keyPath isEqualToString:@"cellHeight"]) {
//        [self.tableView reloadData];
//    }
//}

-(void)dealloc{
    NSLog(@"delloc...");
    
}

@end
